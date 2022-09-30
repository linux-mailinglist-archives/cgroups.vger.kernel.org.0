Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740215F1521
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiI3VoC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiI3VoB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 17:44:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50F1830D8;
        Fri, 30 Sep 2022 14:44:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r18so11621129eja.11;
        Fri, 30 Sep 2022 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=BISgwAbrcAgb3hm0YlO6jJskCwgb0LlGymf7dpfCQwI=;
        b=CgPPqJg6tP9fD1ILsP21XG624Y6UpdrqixMRZwpsVdP9j5Mefsr3n8YLqG/mt/sZ/1
         s5JQUDd7rBUc09KLSn0XpxwMfLGSkUI+40ThNVUQoVVGv9lN7v/68i/+uDEe7cBthFOs
         4FT3d1qH1H8RBEBhHKTQrY3MCLaI+Vk3wwr372epQH7LI0hyX0HYIzHKo3r+CJVrCxls
         6asx6Zmqwv5NFXDD2oA1Z/ivVvavcEeuHuhJEdrdy8pD6OypBRZ5VXcKB2Iu+Lecz8OV
         bR3Vq2/VGsjNboQBB6J5XkCw8zhRSQl2zpXzxFiRpQusFWj5uR+vOc3KAxyMnkG8xV7o
         TJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BISgwAbrcAgb3hm0YlO6jJskCwgb0LlGymf7dpfCQwI=;
        b=fHP1W57ep5RNhc8xbfFIkDu9RiF9Ig00DIzZCEyNHIyK9XiYK6fSizABB9UjCgwl/8
         BPM+8IIr8wjN/GXx2bF96ZSXy0c+5snmrxoDCA7iLk1pwPqbxVBlCTfuCtRu3e3jeRwO
         BLdTB9BcBdUYk+0GF9m5qy2DhC36wU9YHqpiiRhhXbZXD+siQiiqJAqskYTIh1dpjZHj
         LJEwMrbld4cqGObkK4U7xbFmXFbryIkFSlk3PsEUYkf2K8qDsI5v5n0GYKzJtGlyim5+
         9w/gHBZBZjCf7l0uDSS28ZUQMVAvZtp2RioUDiZhKTsqJ4RzNOyyljapjh34tW/BgrSD
         YZdA==
X-Gm-Message-State: ACrzQf0VuWvFTQkAW6idpNskaHtQWb+37MGTHMR0K69RJCTePBPKQmrO
        NP4UBR73jeZPSUTD889OR2A=
X-Google-Smtp-Source: AMsMyM72/cT5oWVhE5DIqip/agmkZTQyj/RNTQtvG/GH4e9HZtEAAWfR7E03hpvu8e2oPP7o66ja8g==
X-Received: by 2002:a17:907:6ea1:b0:783:cc69:342 with SMTP id sh33-20020a1709076ea100b00783cc690342mr7473213ejc.97.1664574239168;
        Fri, 30 Sep 2022 14:43:59 -0700 (PDT)
Received: from krava ([83.240.62.159])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906298b00b0073de0506745sm1685717eje.197.2022.09.30.14.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:43:58 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 30 Sep 2022 23:43:57 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
Message-ID: <YzdjHenrJpooKMjv@krava>
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922041435.709119-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> The recent change in the cgroup will break the backward compatiblity in
> the BPF program.  It should support both old and new kernels using BPF
> CO-RE technique.
> 
> Like the task_struct->__state handling in the offcpu analysis, we can
> check the field name in the cgroup struct.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Arnaldo, I think this should go through the cgroup tree since it depends
> on the earlier change there.  I don't think it'd conflict with other
> perf changes but please let me know if you see any trouble, thanks!

could you please paste the cgroup tree link?

thanks,
jirka

> 
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 488bd398f01d..4fe61043de04 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -43,12 +43,39 @@ struct {
>  	__uint(value_size, sizeof(struct bpf_perf_event_value));
>  } cgrp_readings SEC(".maps");
>  
> +/* new kernel cgroup definition */
> +struct cgroup___new {
> +	int level;
> +	struct cgroup *ancestors[];
> +} __attribute__((preserve_access_index));
> +
> +/* old kernel cgroup definition */
> +struct cgroup___old {
> +	int level;
> +	u64 ancestor_ids[];
> +} __attribute__((preserve_access_index));
> +
>  const volatile __u32 num_events = 1;
>  const volatile __u32 num_cpus = 1;
>  
>  int enabled = 0;
>  int use_cgroup_v2 = 0;
>  
> +static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
> +{
> +	/* recast pointer to capture new type for compiler */
> +	struct cgroup___new *cgrp_new = (void *)cgrp;
> +
> +	if (bpf_core_field_exists(cgrp_new->ancestors)) {
> +		return BPF_CORE_READ(cgrp_new, ancestors[level], kn, id);
> +	} else {
> +		/* recast pointer to capture old type for compiler */
> +		struct cgroup___old *cgrp_old = (void *)cgrp;
> +
> +		return BPF_CORE_READ(cgrp_old, ancestor_ids[level]);
> +	}
> +}
> +
>  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  {
>  	struct task_struct *p = (void *)bpf_get_current_task();
> @@ -70,7 +97,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  			break;
>  
>  		// convert cgroup-id to a map index
> -		cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
> +		cgrp_id = get_cgroup_v1_ancestor_id(cgrp, i);
>  		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
>  		if (!elem)
>  			continue;
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
