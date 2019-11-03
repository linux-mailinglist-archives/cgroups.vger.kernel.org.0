Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056B9ED448
	for <lists+cgroups@lfdr.de>; Sun,  3 Nov 2019 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKCTKD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Nov 2019 14:10:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCTKC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Nov 2019 14:10:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id l10so14666506wrb.2;
        Sun, 03 Nov 2019 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0rob5sFAjpqukpmpefdlqNTPai5iEaFFr8gvrVBR3Q=;
        b=Q+lnISVamhjpceZ6AOa8Tnuy0SKyRtJ2O6C2wm/XOowXFQWDoIBbHBRk73XZ9ssiPi
         oPBfrx+iCmdCz701fbtqyDwyo1yin5fJZHp3U9dJeURTpRMJ7bRgWTU9KK2ENtO73/JB
         SWTzFX0qlq2oiXgF7thBippmF7L2fAR0MhXVGRsk29eILEnFw6/ohrouinQRPhBN/iX6
         /cuu7wSMFiXO/mVsd+obuhlksNN8rEuo6VeA1r+Ttmt6CiSI8/2Wf2LQSwwp6wK5qiL6
         cFmBIv5zSa9RwkdpmIHvJdlPVzvCCISt4CDmwPoGnJwP7pbD2+iCemMDcFlVK7ShhU1h
         geNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C0rob5sFAjpqukpmpefdlqNTPai5iEaFFr8gvrVBR3Q=;
        b=P31Dn1/d1/EI91hFj6PBo4WjebD1KvfvdgL+vpeNscv6dW/6yB0OUxlZznIeDFJqyP
         JAX3dG4CiwgJ5g81vVyDT5wE63vVJ5eRj3PqBaZyN/+BoIUM15NDAnD1cGhq1vY7rpas
         br7JGkETP2YFqN0GbfVAVaqhdpuwFP/xPIcmPcoR/TqML39mcowsJmgsQs6Bb279Sduf
         mQHP71ufRhiqDIO5mrWwmCOuFiNMqJNIjwZbJPlocZI1bC+1LH0P2CKxRfu/PNHKPEgI
         xOfsK0FJPhnOBuny0SpcsJylplfEwJ9tPixfBwQaVBvQyKwHTCNDzdznPwp79+jLiQ+A
         aWPg==
X-Gm-Message-State: APjAAAVb3rBGvyRIP05dGE98+JeIxZ/OhsSX0uEgwskuIXltk6+R/A7v
        pub/mPl1GL/HOutoil7jSbg=
X-Google-Smtp-Source: APXvYqyVsuAIEBIlTUeeKNe/pqxn/kPXT+EmjI/Q3D/wBB2k+kLN1kv8jVWC5bpu9Jds9d/T5/b1DA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr18444822wrn.294.1572808200563;
        Sun, 03 Nov 2019 11:10:00 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a16sm21893335wmd.11.2019.11.03.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 11:09:59 -0800 (PST)
Date:   Sun, 3 Nov 2019 20:09:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH] sched/topology, cpuset: Account for housekeeping CPUs to
 avoid empty cpumasks
Message-ID: <20191103190957.GA39453@gmail.com>
References: <20191102001406.10208-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191102001406.10208-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> Michal noted that a cpuset's effective_cpus can be a non-empy mask, but
> because of the masking done with housekeeping_cpumask(HK_FLAG_DOMAIN)
> further down the line, we can still end up with an empty cpumask being
> passed down to partition_sched_domains_locked().
> 
> Do the proper thing and don't just check the mask is non-empty - check
> that its intersection with housekeeping_cpumask(HK_FLAG_DOMAIN) is
> non-empty.
> 
> Fixes: cd1cb3350561 ("sched/topology: Don't try to build empty sched domains")
> Reported-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/cgroup/cpuset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c87ee6412b36..e4c10785dc7c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -798,9 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
>  			continue;
>  
> +		/*
> +		 * Skip cpusets that would lead to an empty sched domain.
> +		 * That could be because effective_cpus is empty, or because
> +		 * it's only spanning CPUs outside the housekeeping mask.
> +		 */
>  		if (is_sched_load_balance(cp) &&
> -		    !cpumask_empty(cp->effective_cpus))
> +		    cpumask_intersects(cp->effective_cpus,
> +				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
>  			csa[csn++] = cp;


This patch doesn't apply cleanly to Linus's latest tree - which tree is 
this against?

Thanks,

	Ingo
