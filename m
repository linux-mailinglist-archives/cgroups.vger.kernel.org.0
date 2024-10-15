Return-Path: <cgroups+bounces-5126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351899E4B2
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 12:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F2D1F240CF
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E91EABC6;
	Tue, 15 Oct 2024 10:55:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133461E6321;
	Tue, 15 Oct 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989734; cv=none; b=R8ilEgsTTTac4MDYHKV8CXcoWiXSVJnRkvCgOY8AlrSaEC4lND7R4bK+v+T3hWoEaI+9Wg2vvfq+ilKC/CW18xXrm8ONFzaVRYooP0aJY2n2XhjIEv7kLPnK4qQi8XYqWrwRQUxOKWWqdUwgIo+k6IjhgytD70Quk3k2yOxhraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989734; c=relaxed/simple;
	bh=qUWmUQcV9kHfpVCjSVGXIRAYN1rjZxOdfnWp1+SFr6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/bp/wTESDvjsPzhFc/5ks6n0Jyjb4vQMAj4jv5PAuXqMISPbiHgdzZgJ7SEmou4xNHimvX2g4+sZ4B1lY8dmu6IqZiYdTnOs/LUY2cufYPNV+vJeVA1UIHLR5NpSZ4U8t8skM1nNX0jUh+6EDL/HSoozWFrtZUqUcxoZsWLHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91261007;
	Tue, 15 Oct 2024 03:56:01 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D9CC3F51B;
	Tue, 15 Oct 2024 03:55:28 -0700 (PDT)
Message-ID: <315d4258-ea96-4008-8781-9205f41cec6c@arm.com>
Date: Tue, 15 Oct 2024 11:55:26 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Content-Language: en-GB
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Michal Hocko <mhocko@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
 <ghebtxz4xazx57nnujk6dw2qmskyc5fffaxuqk2oip7k2w2wuf@grnsquoevact>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ghebtxz4xazx57nnujk6dw2qmskyc5fffaxuqk2oip7k2w2wuf@grnsquoevact>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 20:59, Shakeel Butt wrote:
> On Mon, Oct 14, 2024 at 11:58:10AM GMT, Ryan Roberts wrote:
>> Previously the seq_buf used for accumulating the memory.stat output was
>> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
>> If 4K is enough on a 4K page system, then it should also be enough on a
>> 64K page system, so we can save 60K om the static buffer used in
>> mem_cgroup_print_oom_meminfo(). Let's make it so.
>>
>> This also has the beneficial side effect of removing a place in the code
>> that assumed PAGE_SIZE is a compile-time constant. So this helps our
>> quest towards supporting boot-time page size selection.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks Shakeel and Johannes, for the acks. Given this patch is totally
independent, I'll plan to resubmit it on its own and hopefully we can get it in
independently of the rest of the series.

Thanks,
Ryan


