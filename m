Return-Path: <cgroups+bounces-15831-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK4NGafxAmrpywEAu9opvQ
	(envelope-from <cgroups+bounces-15831-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:23:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82A51D963
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74B931A8792
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F73B0AC6;
	Tue, 12 May 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLwcBqvs"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A13AF668;
	Tue, 12 May 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576561; cv=none; b=dBkY230AinWPYngISvZLkxU9IVIAcKrlSdRNzwbouvu23nDUvkb17S4VM5mNZ4niZCc+Q8yGmJuuezTa1ApdSx7WnNxEMcaWaBbDGUTIt471eTBSKj/+Iyw69Fds/JbhBEOWIVkVicND9xqufvX1hqLCN6japfuZeP6KPC9r8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576561; c=relaxed/simple;
	bh=cGQpnP2IE2ZPzENjOmgQRCKXBvFqmE6nGUpQ5lxszOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG2Sdwx65uP/yHCZqAX59LE74Qkl5OtmsbTo7b1IDUdgESUUJzRn2DIY8h1k1xAMM3o0+s2OC5i1D86+65e4PWGFTGkonmal7OkA185gL5WRJdaH0lJVFty0W0kBhfh+f7qwqFGDZQgcO0KSEhvG0wE41pP/AIO9qWkqSDveekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLwcBqvs; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778576551; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+cyTZjQS6UqdXmYhbAizO7A1hVVtxlnJezCg5zZ803w=;
	b=qLwcBqvsh5LD+NV8W0eg54jSIJvt0gB8CPyYvTE1RfwYD/ngDA1QozBiucuLzHAIXleQddHy4mCMh/IOfwyyN+jG/3c3YsX+35Nl/eypP1oALs2O7qlTptKoXYcX706gr1MFJ7lqAb5I2AuuIunPR4sTQE3MlZF3+6VoE7Q7mN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X2q-o6n_1778576545;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X2q-o6n_1778576545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 17:02:28 +0800
Message-ID: <a4c22e4c-5669-4323-8229-1da261e9c72f@linux.alibaba.com>
Date: Tue, 12 May 2026 17:02:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] mm/huge_memory: move THP gfp limit helper into
 header
To: Zi Yan <ziy@nvidia.com>, Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Youngjun Park <youngjun.park@lge.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-3-2f23759a76bc@tencent.com>
 <D631DCC9-85F0-4E68-88A0-AD5DE328818E@nvidia.com>
 <CAMgjq7BDmGWaVWBL+52_c=jgs293bgB+Qe-MafKE7dWZRsmx9A@mail.gmail.com>
 <125AABD0-02D5-4656-9F55-4B5BFBD5BD3D@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <125AABD0-02D5-4656-9F55-4B5BFBD5BD3D@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB82A51D963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15831-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,alibaba.com:email,tencent.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action



On 4/22/26 1:23 AM, Zi Yan wrote:
> On 21 Apr 2026, at 13:21, Kairui Song wrote:
> 
>> On Tue, Apr 21, 2026 at 9:14 PM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> On 21 Apr 2026, at 2:16, Kairui Song via B4 Relay wrote:
>>>
>>>> From: Kairui Song <kasong@tencent.com>
>>>>
>>>> Shmem has some special requirements for THP GFP and has to limit it in
>>>> certain zones or provide a more lenient fallback.
>>>>
>>>> We'll use this helper for generic swap THP allocation, which needs to
>>>> support shmem. For a typical GFP_HIGHUSER_MOVABLE swap-in, this helper
>>>> is basically a no-op. But it's necessary for certain shmem users, mostly
>>>> drivers.
>>>>
>>>> No feature change.
>>>>
>>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>>> ---
>>>>   include/linux/huge_mm.h | 30 ++++++++++++++++++++++++++++++
>>>>   mm/shmem.c              | 30 +++---------------------------
>>>>   2 files changed, 33 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 2949e5acff35..ffe5a120eee4 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -237,6 +237,31 @@ static inline bool thp_vma_suitable_order(struct vm_area_struct *vma,
>>>>        return true;
>>>>   }
>>>>
>>>> +/*
>>>> + * Make sure huge_gfp is always more limited than limit_gfp.
>>>> + * Some shmem users want THP allocation to be done less aggressively
>>>> + * and only in certain zone.
>>>> + */
>>>> +static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>>
>>> Would it be better to rename it to thp_swap_limit_gfp_mask() or something
>>> more descriptive? I am just worried about misuses in the future due to
>>> the generic thp prefix.
>>
>> Good idea, I wasn't sure if this might be helpful for any other user,
>> but for now naming it more descriptive does help to avoid misuse.
>>
>> How about thp_shmem_limit_gfp_mask? Ordinary swap is fine with thp
>> gfp, only shmem is a bit special.
>>
> 
> Sounds good to me. Thanks.

Sounds good to me too. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

