Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA95F1C8E
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJAN7E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Oct 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJAN7D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Oct 2022 09:59:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75152CE6D0;
        Sat,  1 Oct 2022 06:59:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nb11so14261498ejc.5;
        Sat, 01 Oct 2022 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=xKd9xq6bw6qI68iHTU/hjvH8L0x2YGL0QK3AOdmJ3AI=;
        b=lQF7IjxlRwt8FCZrwdnNizwSyswVpRaFHzxeLlh9sqhbZN7tDEchQ+QpZrBuXdrip9
         dEb/rkpsJqag+OpBTA7Dhpq8eKm+cj16lssEcdR7hP6UiQJ9oRugsuX9AtiAuG4owPm6
         USCCsprutvxGospLpucVtUelHBFSpkLS9w8uOEhr6sIlMskxXbbvZhqzVtl7UlE7x3bL
         0jErns0AnizLnCtCvOpuz8t9rU+Lck+R8OLTHOi4npl/932rJARoDBbTsg7qMiLcEipt
         1RwD1+IFuDCDa3Gj1QJrRnJR/AFs3lH6lhYLYPzDWUvi4SHgHf3v3CT59ZdxJjHl1aAw
         AbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xKd9xq6bw6qI68iHTU/hjvH8L0x2YGL0QK3AOdmJ3AI=;
        b=fwFqeUegfI7xG89CwWisczajWpL4OlYLCncER7auWH06CLrtzfqKgpgFe4Kk+gnZXj
         omxk9WoVE82OfZpfPTMdOouAggMGN8HMNK/uV3GI4Cw6VXpiTC6cpzH6/qrRNRbnkCkt
         POGoEqj2h/2NJz/7f+CuN12iDTsWI+zmi1VzbAT0dLkKl43UORaf8haWffM5CqTJGeGM
         wjOvLnLREpcdWolMXdwIEVvljxJAhDgejU2cgXSUFa6whIlP2j5tWgdeSbvXKuCU/U3f
         mqy2E6CDN5yWb8ZKDGj9KeolLQZsLxHoq7TBrcU8eS+ldEiI4I3/fj41Pk9dQU5hsdCE
         OC2w==
X-Gm-Message-State: ACrzQf2MpRYJG8hJ/sug63SkeAQSd8ha7RWR6VybNGtNb1DdiIbUpcJ6
        2SUq8E/b2M4STXFJc3jXVJ6Y8uE8D9uGaA==
X-Google-Smtp-Source: AMsMyM4D8YO39YP0jlKUErI+/xrmlglm1nS+bBF3UfBDjME8GICeJAA0mqiUfawfJZ1EoWlaMcobeA==
X-Received: by 2002:a17:907:169e:b0:787:c346:1954 with SMTP id hc30-20020a170907169e00b00787c3461954mr9164816ejc.688.1664632740916;
        Sat, 01 Oct 2022 06:59:00 -0700 (PDT)
Received: from krava ([83.240.62.159])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709063b8900b007813968e154sm2735933ejf.86.2022.10.01.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 06:59:00 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 1 Oct 2022 15:58:59 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
Message-ID: <YzhHo0dJEijtGNzZ@krava>
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

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> Arnaldo, I think this should go through the cgroup tree since it depends
> on the earlier change there.  I don't think it'd conflict with other
> perf changes but please let me know if you see any trouble, thanks!
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
