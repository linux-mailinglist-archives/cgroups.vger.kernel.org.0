Return-Path: <cgroups+bounces-13975-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mItOEDmxlGlbGgIAu9opvQ
	(envelope-from <cgroups+bounces-13975-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:19:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A914EFE3
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00994304E81C
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7637106B;
	Tue, 17 Feb 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtP01V7T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0D36E497
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352352; cv=none; b=uYe2TQvH3tTt4+c5HPUj/i1Dt3HEg6ixjBV6OgS1es1nwE0CZ0vz8dLbR4eMAzZ5tUdfn5OXTz1qNb9rXGe/WjsWoM0T0q9WKeQC9y/x7sZYaz0U/LYe34kmY4EcNhN5Z/2NRm/lybdyLtxYGaJ91bGnUNhecB073e8cbLHdnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352352; c=relaxed/simple;
	bh=uVvbFmXUB18u0DcnJuRzA+yOILKBLpAcQf0siZ3y3yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZcUPEzUc9543UWB7HzttU+ylXZnuU90/hAw9sKX4PTzyJDOP1Ws+D14ecyZ6YHM+aCDpGyGgQMSzccUK3fz1BOsMGeRNUyVlJ+Lv4E2J8sRoZdSQX1SHvEDeuHncOb9x+ZJrBroOoDJlvDrEeFz0+GcEF22F77LWsEPcmzXFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtP01V7T; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233bc1117fso73714c88.0
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771352351; x=1771957151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dh1AV8MM7TPE9F/5A0BmsGHV5nOWLB3oW6lLOMLZNVw=;
        b=JtP01V7TjDsHVP79CiRd/graPflehkSQVUjC9iCnD6DHseUChIletXFVuhLFc/oc2k
         XuGvt3xNnXeCRhwI2Ubg+T+jX6TEyvoDJfivcemsbuOCvdmBiSN2/fnUdiHeTzv1IDFo
         Rk2SANN3KOqMp+WAGxUk4YdL7bp/zYRVV4Pc233LxmmTvTVvcqj2wbl3FBYyEqkPs1rF
         IQr2lAn/xoUPAnmEQNOtAgUPc6Qb31OTv9v8janJQwY64jX0DdkqcFuSd5EP+KUFo4EW
         nlRx3XDhirs1j8oUxxw+plQP4EbYPXMtT25L711sH/WMbTbTtlWGPt3Kvpt68jnFEMEA
         Ky/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771352351; x=1771957151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh1AV8MM7TPE9F/5A0BmsGHV5nOWLB3oW6lLOMLZNVw=;
        b=al80pxJVgIIZCLgITNTCrQa+83on+lH0/U0WZb+wtb8i3wFZDxTO+nuasQccEp+YDt
         OjAJktnNk7Jt2UZGxHG4QC0oomsvwrRlV1nj/r4fRSDfQWoY1NIuyW+tlCPE64E62StV
         TTdilDT1HGYSoEFpk4fk889xm4qZu7UiSRDzBDD1NZBdByDh35fERPadenB9ZKy1iJAG
         gbQ1vVrQcIsgpSlAG7uomemnSHDVPDoUM4wEbKOq9ogT3XCYiRIsr42jGiDdkIuW2x6s
         xtwrSw3XkAPcGJqljc+Q/Z99oLjnIDvlGh+sIVZED5dhnpHa0mJbEmkn9ASV1/+6fpvb
         hmpA==
X-Forwarded-Encrypted: i=1; AJvYcCVN/mRXLRFMHLsaatKuGFAkXjyVy9kKS878iCIcL9gX/G8WRMsYs1ChrncPV5B+uzWTHxWoW2hA@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAOWCIaonhvbm2/LyOz08xzQHaitCYCUQ9PZPqzUvVIj4W/vm
	CzKDwFThLTTsCC+ocZ4kqW6kD3wbPA3wXGTwfawUYlB4Fw1PW4Q4UcmT
X-Gm-Gg: AZuq6aKiXWU7yjedfrhb34Bd9Bw/ohaTEea5L1lhI9b5jPsOkgoIMEz4QQ1L4oYitPN
	HpNgfXSUDlCBIDPLlqSVW0jWBk/BCCEbc10Ua5nBrNHzJRrw0tMw4YS2cEWccfg5zBCo1noITr1
	mw7L+abPZvQCNy58QRMvcEnhOOaWXAKokqwvJ6Y7av+7HVEIJta4iv/J9JdM/Ehx8iFcThQpZ1L
	GMo8rhKVf9GsIqzFiYiN1Xd/nzALiqUitOMv7GgM56RQYf9BlcCX0mehxDYDJgPi++x/cKgcVFJ
	lz0itwTRvw7K9tA0/CHC6qI76EfTZL49P8S4khXhUaBobd3vYSJF76QD6cs/X6qPNK4IIaO9I5v
	NrpeCEwhNNdL57pabooBbfwcBWC3OC9oXrOENakQeQp9N+axuVVxiCsCCUm0WYKLIBvQPVqyf4d
	khrcBKaS1o1+4r21QzP1OyZ0atyEpUywpL
X-Received: by 2002:a05:7022:6709:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-12741015280mr5221990c88.16.1771352350552;
        Tue, 17 Feb 2026 10:19:10 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm19689943c88.5.2026.02.17.10.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:19:10 -0800 (PST)
Message-ID: <c71f5dc7-d337-4510-96c4-38a83fca29ef@gmail.com>
Date: Tue, 17 Feb 2026 10:19:08 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com> <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com> <aZOHIQj3pJ-9dW_0@tiehlicka>
 <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com> <aZRg_ZSDkbGWv7Vq@tiehlicka>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZRg_ZSDkbGWv7Vq@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13975-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE8A914EFE3
X-Rspamd-Action: no action

On 2/17/26 4:37 AM, Michal Hocko wrote:
> On Mon 16-02-26 23:48:42, JP Kobryn (Meta) wrote:
>> On 2/16/26 1:07 PM, Michal Hocko wrote:
> [...]
>>> [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
>>> target node even when the allocation is from a remote node from the
>>> "local" POV.
>>
>> It's a good point. The accounting as a result of fallback cases
>> shouldn't detract from an investigation though. We're interested in the
>> node(s) under pressure so the relatively few fallback allocations would
>> land on nodes that are not under pressure and could be viewed as
>> acceptable noise.
> 
> This is really confusing. You simply have no means to tell the
> difference between the requested node and the real node used so you
> cannot really say whether the memory pressure is because of fallbacks or
> your mempolicy configurations. That means that you cannot tell the
> difference between the source of the pressure and victim of that
> pressure.

What if I excluded the fallback cases? I could get the actual node from
the allocated page and compare against the requested node or node mask.

