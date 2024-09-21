Return-Path: <cgroups+bounces-4926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FD97DBFB
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4360B282CD0
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9814B960;
	Sat, 21 Sep 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObgtDunf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BB14290
	for <cgroups@vger.kernel.org>; Sat, 21 Sep 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726903821; cv=none; b=pUzrV6seoXjEkRTxjqj7R/VIZ5yz5NRQoxgogxffhaIBqHeaGCrQ8trLiYroC1qTbqrfzWkp8l1X3Dak5VWTv5FSsaNqEysU+aB6ACw2mo/8JUNC6OItsf1VtzCbO5sxSEXgwnkSjJkr/6tvdUnxKPNXWofWDyJPk+16leTsWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726903821; c=relaxed/simple;
	bh=z+hccMl8T/g4EuK4dkYhejTd+uidfLcfUtyLjsHtcDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtDR08PRAk9MRy0wm5ljXvF1pw7cp0pnIDfBhrFJCZC0xoDwtGTmXEcN/IqTI+Ol9XYpDk/bZ+UoQ5umoIglYcu24937AEzv6mztQ/bODl78aXW2dmCqTEuIqxmnSnTvGUJeWW45Dp8MtuX1KHUc4rEtEuD/G9HTzXTpcXWBwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObgtDunf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726903818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzvMnsM+vzdU7NKDHCnrJ1kjDqhwnForMED4ERX1KeI=;
	b=ObgtDunf5cHARSbxTz9O/jtc2m7ce6CiKOhvhksZ3Ytv1E7RVX4Ows4mZEHpMtwUEpEOgM
	W23R2nCJTdNF4VdhHsJN519hNQerop4TmRXcTZqb7rLS0oKU9dH/wb0ls0F6ZsQc5SyHc9
	Ek5S2lYtylyxuC2cGVaBVUQUQq/yZP4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-xsEMrhcCOm6jF64Lgyb3jQ-1; Sat,
 21 Sep 2024 03:30:16 -0400
X-MC-Unique: xsEMrhcCOm6jF64Lgyb3jQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9C3219137A7;
	Sat, 21 Sep 2024 07:30:14 +0000 (UTC)
Received: from [10.45.224.28] (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C68230001A1;
	Sat, 21 Sep 2024 07:30:09 +0000 (UTC)
Message-ID: <031a122c-f480-4dbc-8022-ca829f4ce500@redhat.com>
Date: Sat, 21 Sep 2024 03:30:07 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] cpu/bugs: cgroup: Add a cgroup knob to bypass CPU
 mitigations
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
 <20240919-selective-mitigation-v1-2-1846cf41895e@linux.intel.com>
 <5f48073d-8b4e-4569-af4f-3a9b5586d7ad@redhat.com>
 <20240920075448.djesnjetefwa4yl4@desk>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240920075448.djesnjetefwa4yl4@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 9/20/24 03:54, Pawan Gupta wrote:
>>>    static int cpu_local_stat_show(struct seq_file *seq, void *v)
>>>    {
>>>    	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
>>> @@ -5290,6 +5326,12 @@ static struct cftype cgroup_base_files[] = {
>>>    		.name = "cpu.stat.local",
>>>    		.seq_show = cpu_local_stat_show,
>>>    	},
>>> +	{
>>> +		.name = "cpu.skip_mitigation",
>>> +		.flags = CFTYPE_NOT_ON_ROOT,
>>> +		.seq_show = cpu_skip_mitigation_show,
>>> +		.write = cgroup_skip_mitigation_write,
>>> +	},
>>>    	{ }	/* terminate */
>>>    };
>> Since this control knob is effective only for x86_64, should we enable this
>> only for this architecture?
> This should be under a CONFIG option that depends on the architecture
> selected. I don't see a reason why it will not be useful for other archs.

Using a CONFIG option looks fine to me. I just want to make sure that 
arches that don't support it won't have a useless control knob show up.

Cheers,
Longman


