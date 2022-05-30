Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282A05378AE
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiE3I54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiE3I5z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 04:57:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4C56204
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 01:57:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v9so10889133lja.12
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 01:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lAZ+j4i7HJwXaSuMT5P/9OWwy3X9DfOqr/MHBEG4KHI=;
        b=aDnPkj6r5ZzjADGCBpBF0k2//QShcfRFpuzPbuPgGZvD1xyq81kSN27OswexYp7b4Y
         +sZn/ScrbzAoL29odFLAPT/8ckwv6U08kqj4rQhfGnq+w/Ci3V3z9WDQQSuOlz2fdTGu
         +Xq9fkeacpiSJPniUbxXbjMJSA//GNTsaKoS3JfWa1O2rtOa7HtZJ3wnbZi/a3S82gDW
         rd2RMVXROO10vULaokSHE2OCkAc3nm9DLdIfU9vG8x7/1sPPvKqqqrzFpLLDbZ2DDT+C
         pEYB3X5lXUGsvCUc3usc7dqIROPrdOvOX8YXV8zE2MbysPBjl/kzIhyBm3cCRN03/5ot
         yfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lAZ+j4i7HJwXaSuMT5P/9OWwy3X9DfOqr/MHBEG4KHI=;
        b=SPIsoGl5W4Osed54ausuxgdxQVv6lhNCcybZpO14buJv/6xK8SfkQrEG6jMcGpvsOE
         uOpOPSl1aF2CEQiQHoBIzpRZIHW3KhNUycuuFUc2ilUTu8XdyqtyZqgBgTInZzpG1XI1
         Ao0GGQ27mEADRpmzToSEotc4Liu89FnXMu0At8Uw2EMSJ+2d9c6nn6EZoUt0IXoVfcAG
         lC0UIMTfTj7f86eZaM9EeQg/tThSL2O+uUGHu3ohYpfPQTYl2G8HLx+BOrO54zYwdRDV
         r7WdI/zwWidDs/U5JfkV9oCTmMEOezYWmWirD34OD8e4l2u1LG/L+eALj3/9I1t00LJY
         AB5Q==
X-Gm-Message-State: AOAM532AfDf/JOn1DuWW7bO385eZDEIw3yEj8DZs2m9or+mfoh0CEKc3
        dOd/5cWuoolQC1K3GMOX7Fyd5w==
X-Google-Smtp-Source: ABdhPJwRnA1vjBQ/lHk4ny41879c4r+co+vuchDOUFjscAu4AhPvLAaz+2PEIyemFIqMm0E91oVE0w==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr33595563ljq.44.1653901072467;
        Mon, 30 May 2022 01:57:52 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id f3-20020a05651201c300b0047408564c31sm2177490lfp.286.2022.05.30.01.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 01:57:52 -0700 (PDT)
Message-ID: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
Date:   Mon, 30 May 2022 11:57:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH memcg v5] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
References: <CALvZod5HugCO2G3+Av3pXC6s2sy0zKW_HRaRyhOO9GOOWV1SsQ@mail.gmail.com>
 <0ccfe7a4-c178-0b66-d481-2326c85a8ffb@openvz.org>
In-Reply-To: <0ccfe7a4-c178-0b66-d481-2326c85a8ffb@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Andrew,
could you please pick up this patch?

Thank you,
	Vasily Averin

On 5/2/22 03:10, Vasily Averin wrote:
> __register_pernet_operations() executes init hook of registered
> pernet_operation structure in all existing net namespaces.
> 
> Typically, these hooks are called by a process associated with
> the specified net namespace, and all __GFP_ACCOUNT marked
> allocation are accounted for corresponding container/memcg.
> 
> However __register_pernet_operations() calls the hooks in the same
> context, and as a result all marked allocations are accounted
> to one memcg for all processed net namespaces.
> 
> This patch adjusts active memcg for each net namespace and helps
> to account memory allocated inside ops_init() into the proper memcg.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> 
> ---
> v5: documented get_mem_cgroup_from_obj() and for mem_cgroup_or_root()
>     functions, asked by Shakeel.
> 
> v4: get_mem_cgroup_from_kmem() renamed to get_mem_cgroup_from_obj(),
>     get_net_memcg() renamed to mem_cgroup_or_root(), suggested by Roman.
> 
> v3: put_net_memcg() replaced by an alreay existing mem_cgroup_put()
>     It checks memcg before accessing it, this is required for
>     __register_pernet_operations() called before memcg initialization.
>     Additionally fixed leading whitespaces in non-memcg_kmem version
>     of mem_cgroup_from_obj().
> 
> v2: introduced get/put_net_memcg(),
>     new functions are moved under CONFIG_MEMCG_KMEM
>     to fix compilation issues reported by Intel's kernel test robot
> 
> v1: introduced get_mem_cgroup_from_kmem(), which takes the refcount
>     for the found memcg, suggested by Shakeel
> ---
>  include/linux/memcontrol.h | 47 +++++++++++++++++++++++++++++++++++++-
>  net/core/net_namespace.c   |  7 ++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0abbd685703b..6405f9b8f5a8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1714,6 +1714,42 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>  
>  struct mem_cgroup *mem_cgroup_from_obj(void *p);
>  
> +/**
> + * get_mem_cgroup_from_obj - get a memcg associated with passed kernel object.
> + * @p: pointer to object from which memcg should be extracted. It can be NULL.
> + *
> + * Retrieves the memory group into which the memory of the pointed kernel
> + * object is accounted. If memcg is found, its reference is taken.
> + * If a passed kernel object is uncharged, or if proper memcg cannot be found,
> + * as well as if mem_cgroup is disabled, NULL is returned.
> + *
> + * Return: valid memcg pointer with taken reference or NULL.
> + */
> +static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	rcu_read_lock();
> +	do {
> +		memcg = mem_cgroup_from_obj(p);
> +	} while (memcg && !css_tryget(&memcg->css));
> +	rcu_read_unlock();
> +	return memcg;
> +}
> +
> +/**
> + * mem_cgroup_or_root - always returns a pointer to a valid memory cgroup.
> + * @memcg: pointer to a valid memory cgroup or NULL.
> + *
> + * If passed argument is not NULL, returns it without any additional checks
> + * and changes. Otherwise, root_mem_cgroup is returned.
> + *
> + * NOTE: root_mem_cgroup can be NULL during early boot.
> + */
> +static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
> +{
> +	return memcg ? memcg : root_mem_cgroup;
> +}
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1763,9 +1799,18 @@ static inline void memcg_put_cache_ids(void)
>  
>  static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  {
> -       return NULL;
> +	return NULL;
>  }
>  
> +static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> +{
> +	return NULL;
> +}
> +
> +static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a5b5bb99c644..240f3db77dec 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -26,6 +26,7 @@
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  
> +#include <linux/sched/mm.h>
>  /*
>   *	Our network namespace constructor/destructor lists
>   */
> @@ -1147,7 +1148,13 @@ static int __register_pernet_operations(struct list_head *list,
>  		 * setup_net() and cleanup_net() are not possible.
>  		 */
>  		for_each_net(net) {
> +			struct mem_cgroup *old, *memcg;
> +
> +			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
> +			old = set_active_memcg(memcg);
>  			error = ops_init(ops, net);
> +			set_active_memcg(old);
> +			mem_cgroup_put(memcg);
>  			if (error)
>  				goto out_undo;
>  			list_add_tail(&net->exit_list, &net_exit_list);

