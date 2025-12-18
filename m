Return-Path: <cgroups+bounces-12479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE003CCA96C
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22CCE304CC2B
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9F271448;
	Thu, 18 Dec 2025 07:09:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CD287505;
	Thu, 18 Dec 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041779; cv=none; b=q2VpvDaSDzAYFEjVGT8UcJ+Ds4w5JQ4q8QJTC3Bn8nr+KdVxOkCxD+BGTQ6ZzmmXd+j4GqrLVKR9Gb3QNUXNyuR/t2xSOqwlY9lmFAiODLsI7x9kX4DKbKNwDmK8A89jNcshXexBGjki1ScHqNv/5WgSQKKTT1wuGuSLiK7BOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041779; c=relaxed/simple;
	bh=I8bS8hGMIQNWIepdLF0ahsyACIVTlBaWIlyjzAiSD2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSTNCCEL+pBL7gyXBzGyJpVuGGl3yYSGiBeY5Tw3/yuPbaayTy4uWpcnICny4znfOCVRtUcg3JWkXL04weWpem+uU6l+2g3XrNOIOql6sUiZXm7EDSlqG05Eha2Ed/KwQintZZ7Rvz38LKXcGjuh+7xD9RAl7tm/SrdQfGHMwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX1xF5v9xzYQtkG;
	Thu, 18 Dec 2025 15:09:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 02B0B4056F;
	Thu, 18 Dec 2025 15:09:34 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDHFRSsqENpKsBYAg--.2281S2;
	Thu, 18 Dec 2025 15:09:33 +0800 (CST)
Message-ID: <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
Date: Thu, 18 Dec 2025 15:09:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251217162744.352391-4-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHFRSsqENpKsBYAg--.2281S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrCF4ktryUZFWfZFWUArb_yoWrJFyDpF
	1DCwnxtw4fAryrGr1qq342vF9agw4Fqr4UC34UJw48JF9Ikrn7Xr1kAF15JFyrAFZ2gr1S
	vFW5uryDC34jqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 0:27, Michal Koutný wrote:
> cgroup::ancestors includes self, i.e. root cgroups have one ancestor but
> their level is 0. Change the value that we store inside struct cgroup
> and use an inlined helper where we need to know the level. This way we
> preserve the concept of 0-based levels and we can utilize __counted_by
> constraint to guard ancestors access. (We could've used level value as a
> counter for _low_ancestors but that would have no benefit since we never
> access data through this flexible array alias.)
> 
> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  include/linux/cgroup-defs.h | 19 ++++++++-----------
>  include/linux/cgroup.h      |  2 +-
>  kernel/cgroup/cgroup.c      |  3 ++-
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 9247e437da5ce..8ce1ae9bea909 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -475,14 +475,6 @@ struct cgroup {
>  
>  	unsigned long flags;		/* "unsigned long" so bitops work */
>  
> -	/*
> -	 * The depth this cgroup is at.  The root is at depth zero and each
> -	 * step down the hierarchy increments the level.  This along with
> -	 * ancestors[] can determine whether a given cgroup is a
> -	 * descendant of another without traversing the hierarchy.
> -	 */
> -	int level;
> -

Note that this level may already be used in existing BPF programs (e.g.,
tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consider compatibility here?

>  	/* Maximum allowed descent tree depth */
>  	int max_depth;
>  
> @@ -625,13 +617,18 @@ struct cgroup {
>  	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>  #endif
>  
> -	/* All ancestors including self */
>  	union {
>  		struct {
> -			void *_sentinel[0]; /* XXX to avoid 'flexible array member in a struct with no named members' */
> -			struct cgroup *ancestors[];
> +			int nr_ancestors;	/* do not use directly but via cgroup_level() */
> +			/*
> +			 * All ancestors including self.
> +			 * ancestors[] can determine whether a given cgroup is a
> +			 * descendant of another without traversing the hierarchy.
> +			 */
> +			struct cgroup *ancestors[] __counted_by(nr_ancestors);
>  		};
>  		struct {
> +			int _nr_ancestors;	/* auxiliary padding, see nr_ancestors above */
>  			struct cgroup *_root_ancestor;
>  			struct cgroup *_low_ancestors[];
>  		};
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 0290878ebad26..45f720b9ecedd 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -534,7 +534,7 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
>   */
>  static inline int cgroup_level(struct cgroup *cgrp)
>  {
> -	return cgrp->level;
> +	return cgrp->nr_ancestors - 1;
>  }
>  
>  /**
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e011f1dd6d87f..5110d3e13d125 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2197,6 +2197,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
>  	}
>  	root_cgrp->kn = kernfs_root_to_node(root->kf_root);
>  	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
> +	root_cgrp->nr_ancestors = 1; /* stored in _root_ancestor */
>  	root_cgrp->ancestors[0] = root_cgrp;
>  
>  	ret = css_populate_dir(&root_cgrp->self);
> @@ -5869,7 +5870,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>  
>  	cgrp->self.parent = &parent->self;
>  	cgrp->root = root;
> -	cgrp->level = level;
> +	cgrp->nr_ancestors = parent->nr_ancestors + 1;
>  
>  	/*
>  	 * Now that init_cgroup_housekeeping() has been called and cgrp->self

-- 
Best regards,
Ridong


