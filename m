Return-Path: <cgroups+bounces-6087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662FA095B4
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 16:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC5E188F9EA
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1062135A0;
	Fri, 10 Jan 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNMpkElf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B921325C
	for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522810; cv=none; b=UnmhVCpj0eSOorSUmhUMqzyMCp2sM1UJ+EZhHNEMmdc+qaW6/cwWyUCpk73Qcw4PddwMH5UjyzT8Uuzm1iqB0EUIQyhaXWF2DaVe/So5cmpbiXxGn06tBc/wnw0wvx/UGCSJrwFlOGJAI7Ab6UTcTd/98ZvUxkaOtFewzuBSktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522810; c=relaxed/simple;
	bh=Ex4aV9Edi1DChr2/EY5NFS6dOSHhG+EPFES7jbVumoM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nBymA4oKSf48GYYiT+GoQAVN+v8Ro3e6lRckrL7+UC4iUHez2WB0hBSpwZO/+ne1RPP9y5Ni/U2SS2e3ZZzlibfOhXrGb4QVr5hBBl876nzwiHHCD06DCiVFk8M843qnR1GfC3NWiPAUlI3pTQ8Xv+GZeIp2DuW1fytNRCaUf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNMpkElf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736522806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdBZ2RENbUeoKAX57hmRqAxpZLgO4MtDE/EdcNWg7K8=;
	b=LNMpkElfi8pSiWAvBBDOHGV/TK5jQFQHec/URd2+LMWWyBcFXTzFMnRc3NcvNdyCdwkjEn
	O9PMCxuQx2Ir0bc50DRpjwkt/Kab8ZeST+ORnSjJ6scBir3GRF5O8ejmsM8A03s3LUril9
	PsBjML3ceNrmfwao6jmh+z8bk+Wt2iE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-OUPhoTQJNTqlDYwGnjHL_w-1; Fri, 10 Jan 2025 10:26:45 -0500
X-MC-Unique: OUPhoTQJNTqlDYwGnjHL_w-1
X-Mimecast-MFC-AGG-ID: OUPhoTQJNTqlDYwGnjHL_w
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6eeef7cb8so314753685a.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 07:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522804; x=1737127604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdBZ2RENbUeoKAX57hmRqAxpZLgO4MtDE/EdcNWg7K8=;
        b=FgBdZwcOHj+wSN2c5appxUl17lDxRxRXRDUuSRME24I6B7l73JtIhPcpZlvAQMw941
         yDQYbsNEG+LfA0Yhiw9cgtrOFWlZZpbc0Cz9DozKpdE3MHIFGeUPUOZiNaZ+gsedzOAh
         JZFbOMD0b8iqRoGBdZO6cV1994aiPzoPAWZK3oRDg/X6RHeGNkorLxPG2T5eb99zupux
         Z3oZdU/t7QRTmYWjgUBRJEmUAsnsKb2Jn4xcAKE4Ck7m2PFj+55YzkGwIcGUqAPcgs5U
         rmDnkG4MPFrrKhUOaT4Uk/XRBTuQLATpUt6CAlgOYiTm0FPYL22GD/TbRbgHixV0+W/f
         PkNw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0z96YshynhD5jpqTvDhRW1feOht3YjRT9NehmC8rU3fZLKBB3d0ej+CrBbMEMjbFVBt97s6g@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqEGHMAAdWs5MyI56ORY+neHSEUs5noMeoLTN2TG03P/smFQY
	MrTOtBt6aZJvUNHaFrTGxpa5GwgJQaJXJ6HhMv0DnNcuNhBxWNmWAWQm4CeL0kInQQ2jS70LM46
	TMmr94JPnOMgyWdfIBOtarOTxVggjg95Cs+ydlzCWgTOuXAURuqROitSl8P1URrM=
X-Gm-Gg: ASbGncuO/Kf4mZylhQOXjXGWWOt/ZL/1zYZzM41XxW1PsjThOGYyplMOyK1hxvDfqIZ
	RqJYzV68PSQFgNEe+zJtboSRudhpbUkwvkojRPsF3zCWeLfFwzmoI6/lwzpEBwILE2rIi0hBxS8
	5RzBPGa1Sr8HNxYsphCKEwABcm6RI+CqsFyxLVCTWw5XMJp4yggT4s+MQLV7KNHVS0qCw33zeO6
	5wKujgICsmkpbuHMolpxMKTmvJDdc4pMz7zDSJemaYzLTov8W13uC9KVYUJdpXKpHuKLyhiEhro
	owWf/wuEfsNb4g7/vWLRtZuF
X-Received: by 2002:a05:620a:404b:b0:7b6:eab3:cdd4 with SMTP id af79cd13be357-7bcd97705fcmr1737385385a.50.1736522804671;
        Fri, 10 Jan 2025 07:26:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSahWFMhjNZQYhJ7J2TpMjNCXwN3Xv7VEbJyK4KJevacPGwI8K2RfhqqheueQiOBPMKvPiZQ==
X-Received: by 2002:a05:620a:404b:b0:7b6:eab3:cdd4 with SMTP id af79cd13be357-7bcd97705fcmr1737381785a.50.1736522804298;
        Fri, 10 Jan 2025 07:26:44 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516027sm181319985a.110.2025.01.10.07.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:26:43 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a8d5ded2-6921-4c6b-890d-17227147c28d@redhat.com>
Date: Fri, 10 Jan 2025 10:26:40 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat
 description to reflect possible units
To: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250110123019.423725-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/10/25 7:30 AM, Li Zhijian wrote:
> The description of the memory.numa_stat file has been updated to clarify
> that the output values can be in bytes or pages. This change ensures that
> users are aware that the unit of measurement for memory values can vary
> and should be verified by consulting the memory.stat
>
> It's known that
> workingset_*, pgdemote_* and pgpromote_success are counted in pages
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 315ede811c9d..5d1d44547409 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1427,7 +1427,7 @@ The following nested keys are defined.
>   	types of memory, type-specific details, and other information
>   	on the state and past events of the memory management system.
>   
> -	All memory amounts are in bytes.
> +	All memory amounts are in bytes or bytes.

You mean "bytes or pages". Right?

Cheers,
Longman


