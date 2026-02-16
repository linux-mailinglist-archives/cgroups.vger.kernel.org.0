Return-Path: <cgroups+bounces-13968-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COGiI+tYk2k73wEAu9opvQ
	(envelope-from <cgroups+bounces-13968-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 18:50:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690E146CB3
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B92F3008C3A
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7F2E7BD6;
	Mon, 16 Feb 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft9H30wb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0932D8DB5
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264233; cv=none; b=jkTeMXoumufIZ+uk7GnSsvo13RTOqN07EHM1rzHHU6IZwtWOmn4G0MHXwKWHtVTqeWzvwORA0tnAxWID+sUvXhdb77D/pJNcfQuEgv6EYIRT/xg0AFcrRfJ841jlvXRMYRvG6Ks1tgYb1PKQ7HwnafdAx9UxNhjJO7T5xhsDN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264233; c=relaxed/simple;
	bh=Ec4ypCO7FiJJB+yavcc9YDym7HBY5xKLTV2mp01Hofw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiY7l2pqVCJn52Jxyk6IFwR+hRfWOZ9kh2MJaEPlpkBaNJCIrlADd9rgN/58Or2iXKJQQ+lL3sI/0WD8slBtr+WgQ57E6M0b4pj8L5/lkllklE+lNmZiLOIwp1xjC4f471TTNRDmjasy5/60Eo3YjNzFsooNOT4FbZJRxfRas0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft9H30wb; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso6085550eec.0
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264231; x=1771869031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv95Lg9oAGKyC92FTr/4yJbiWOBA02orWovY9nKn8Ws=;
        b=ft9H30wbkzAnQF+R4OSZxzM2CdqelCDfXp2GDbirmmg1h8jPPKF1zj5zn7Ul2l+xDR
         rqli/WP3bGHpggZ4ke2kDg6FxsO/HClYfV0Th0CsoOHhPxuh+9uvcpB0u2BjO9Kedaeq
         BvTsa/mOQlYwqvOOjWE9X2EHBYbaPQAP9XKq+/TtFUlyMJuIofnMq/OezPDCcf6f8IiL
         xnPZz4xlQ46eYF8fAxMTL8rDEC/IVuWQeMvsec+p9aa5mAxNgehgDNEkubc6JwPbwhWv
         KNMzm4aU2hDEQd5rNb6D4pSu26moMBQkm5r2n814gzmYs/zah9xsa3vI773O7tQKIyA7
         mb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264231; x=1771869031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv95Lg9oAGKyC92FTr/4yJbiWOBA02orWovY9nKn8Ws=;
        b=P3HQJzdJvIBKYOOxhorgrBdlF0Pfjp244/pD7sP0dM1JwJyItZrbd9rcPtaNwaU+/p
         iDekirvDClneTc+EMKJilxgG8euJc2ORkGF07JgLVhJ3seXPASvV56rrUO2UTVNeAGFb
         rPQcPifA3Tw2Vr80FR0IT/2llsOn8ShnEjKIr79Fp+mUy8LA7fitaV3mEtQGDXYxme3x
         rswhvqxU8vNoe0tjqEHzN9A3Rh2rlcdLC82Kj/BB8KdNT/0XNo+ST0UWeV+wNAg4FHYk
         814XOF0wInA71PnymFOYOF7VYIVILru2hE5bGPD7LlECbgIaiy5H5CAnV1orYUJGIR6J
         OIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBrTkHTNiTfNlyfgdLbQNwel1DukQWZzwofH3bgxNxKQRiSWwHRn9FvfrThnf06vPXJqefuq+B@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYJ+eQsIfuBcXL7uEQt00u+M/eXqZ4CCx1UPtIbSEaAv2Xfdk
	vdJdVkIv3LQgFJWWc5aSFtuWU6ya610y8LTSHypI9gxOB6C8thhbWuSd
X-Gm-Gg: AZuq6aIoaq+rFIfozUHxIbGU0Zz9qNG8cG5WRueoqSf28EWKqVuOXfOBa7kYV7MBz92
	MnzzspX0v1t9/HC5Z/EFJFUWArXkUyulmaKsctUITFuTT4/dAcAX0xC/SpGW8cv5957im8z5V8Q
	WkKSVY7iaRf4ZP/+dJD9UXRSd77rpGmwdsu4ljjYn1YFFn/LFDm3STIy60Lh/tDZfZagusL4JsO
	ZqCZBFU8PfyTSmE6XnXrczYeVpck338BciE1iVhHAmosQ9CtLNYP/boKh+yJ/CT9k45I1g9Nbbf
	G0bMqmpoGd2mEX5L3Tqs+oe8xeMi35hI1QLHBku+MGaYETK6fYY/7crL/wrHgIPTRQwU1/2lXNE
	GtWTfuzBrROGKDm3XtK64KGmXVOy5IZtyiCjH8KzTG8B80PJ5fFnWa65DXR8Fx+mYKeHjU1oaoY
	6yLrxGlapo5/Z5I2XRJbJ0USRrtISX0Y9LjF5mXU5BkvA=
X-Received: by 2002:a05:7300:23d3:b0:2ba:7606:ace0 with SMTP id 5a478bee46e88-2babc5356bdmr5353650eec.25.1771264230825;
        Mon, 16 Feb 2026 09:50:30 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66c24esm10455308eec.27.2026.02.16.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:50:30 -0800 (PST)
Message-ID: <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
Date: Mon, 16 Feb 2026 09:50:26 -0800
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
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZLUm95Y-dKkdBWI@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-13968-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3690E146CB3
X-Rspamd-Action: no action

On 2/16/26 12:26 AM, Michal Hocko wrote:
> On Thu 12-02-26 13:22:56, JP Kobryn wrote:
>> On 2/11/26 11:29 PM, Michal Hocko wrote:
>>> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>>>> It would be useful to see a breakdown of allocations to understand which
>>>> NUMA policies are driving them. For example, when investigating memory
>>>> pressure, having policy-specific counts could show that allocations were
>>>> bound to the affected node (via MPOL_BIND).
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters can provide correlation between a mempolicy and pressure on a
>>>> given node.
>>>
>>> Could you be more specific how exactly do you plan to use those
>>> counters?
>>
>> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
>> we identify the affected node(s), the new mpol counters (this patch)
>> allow us correlate the pressure to the mempolicy driving it.
> 
> I would appreciate somehow more specificity. You are adding counters
> that are not really easy to drop once they are in. Sure we have
> precedence of dropping some counters in the past so this is not as hard
> as usual userspace APIs but still...
> 
> How exactly do you tolerate mempolicy allocations to specific nodes?
> While MPOL_MBIND is quite straightforward others are less so.

The design does account for this regardless of the policy. In the call
to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
attributed to the node where the page actually landed.

