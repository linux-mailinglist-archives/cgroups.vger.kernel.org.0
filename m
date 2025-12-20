Return-Path: <cgroups+bounces-12550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CACD2ACC
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD7330255A0
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD32F83D8;
	Sat, 20 Dec 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNYiqiqq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D132F7AD2
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766220141; cv=none; b=QmIh+xKL7U+dmui9f/Cf4qBm+LDKLfSvYCDBesfMg4XrBPkc4yOKXMvhX9wfxc2nWO9gH6Gdrm0ZkdOxt2qhL5qQCd9pofjCg+uaz5OQ01kptg/93BXphJG+CfgQyfaXmyWEPh95DjALZrg5+hYXsx0L7yCJuSDfB5HDW793Ok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766220141; c=relaxed/simple;
	bh=svfn5vyKTVat+CW0ije/SnfdLEUGc1F143E/K4DQAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lqN5WqD7qWu3uhEx2VLqrAxdA0luFLAY8ebyiEJ6WAVXcfSOQSzsiROEGEV1ofwn2EXY/oViGQ2rZvcjzXbngSTiW+2Sa0wqV/uUsn0+a2S+S1jpxeSfO1D2V4cCLeAe/IgytQj/1ssPma30hEGswEzTuhmEuLTzZJaKG6qdPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNYiqiqq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso16939725e9.3
        for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 00:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766220137; x=1766824937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+I2LK6f7oBL2gPHrNh5LScuUw6duOSEcjqycBnlXrA=;
        b=oNYiqiqqcpzAGLvwWTSYl9FOBGQKVOJd/Jf1oah6hd5bxPSXu4LBEk24n2JQYxNHvM
         ty1G2lsPUUdFwJiCHdiw+gSozmwv/NUS94e3r4uP0txpwCtQG95nXV/xMoLyyAD1f4yo
         qTgEQwIWspfqJY/KEbnjok2eqW4xgFmGxr6YKUyHxlfpmobVZcEAc3QFWULB+64sb6nm
         WotOsTBphB6NdM9KWN+HWZRRehDbZCRBCo1+ahYfuJL911M5JKIGSd73+ll2OTCu/xiT
         oW5Db8rLaXTq5pWDnKNkiPrQ1YgByhLiKRndnk5VfOz95VCFvl8CetHRd2xHiBzPy5yr
         8arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766220137; x=1766824937;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+I2LK6f7oBL2gPHrNh5LScuUw6duOSEcjqycBnlXrA=;
        b=JzxiurHBOis0pQOCJ7w7j1M+gHCN7yjH27T0UUooNJ1+ArB2dmh9mG3Ely/JRlpS5l
         1tqY+KdLcxI/ua8BX3lu8Gc6S95ATc16rO3RJuoXLyOWtqqRqjS7Iok3gpaeGCjMBfAx
         q0O4cih0YzFcenMrq3gtmpwFSijmBd5YDiJxD/j8ylhbU5xWkRn6CLCSgtzW/XH18tJO
         +Z12eh1c39wZxNnfHRxq/zNvltSt52hjkLY2CN1mJmzjUCdX2eYJE+k0O5xI9+tb/A1H
         MVPOB61P8FFWggyiY32XfYj/LK+vQJ8qdgX003I/XJCOoVpXf6+REUPjIHxVLunwG751
         aEPg==
X-Gm-Message-State: AOJu0YxoWBirtGxY4qwtPQtaksPjQP7n4P05sIC92RrPD4cZTCGT+GqN
	jIRl9iRggOP9TPifcVurFmodJ4edccrXlI2f9Buw/1YWS0pIp3t4UkdoMG5Fc6PT+Sw=
X-Gm-Gg: AY/fxX41mZ+PpzCnUgJPXuVm8dgdvThc1IJlvLx/qfCmVR8dgPRMTMkaj7CnYvGvnD0
	iF2JIKVvFTBopSmXxBVnYyYKP2crZIeC+ltXaob2l8ciEdtFNv+fUKKHaTOtqQVmJtrU8Y78HBF
	3/Sy5omXvZQrzK9gvHlrI2uJDEpl8/6Gqo4UKm8N8IaL8lhtDmM5QHK6upd+maEISsMRzefZVCv
	tzK3+t1HFF6+XRmzEI0YnUz+h+nyl7srgs7UcAU5GfZj5ahfwWD6z/661BZdrFg05FkUb2bSRT3
	KQREecLzx96zpg1GKIKGmFuXQdzQQTHSAifpy5phloUBvkojmtphaHPmmLhFb3eu/FHpT7WWyZ5
	jkktW1kfBD3zxxhJyuoBTr31kHiZSmgJ8fP89bnpTx0KXF9O32tiwOjzbJRbn/uold358XXFbzH
	D2PZi3tQpjVkwfTa0Q
X-Google-Smtp-Source: AGHT+IHtRbWgl2RSD+rYoaigPaOxhiGwTFusRwdOJoHeGKPb+/SADAdr74pYUqwn3PR+u79cBU/L9g==
X-Received: by 2002:a05:600c:3b8d:b0:477:7725:c16a with SMTP id 5b1f17b1804b1-47d1953da58mr58896275e9.10.1766220136975;
        Sat, 20 Dec 2025 00:42:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193cba81sm80792385e9.10.2025.12.20.00.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 00:42:16 -0800 (PST)
Date: Sat, 20 Dec 2025 11:42:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org
Subject: [bug report] cpuset: separate generate_sched_domains for v1 and v2
Message-ID: <aUZhZUHHDsMpBwIw@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chen Ridong,

Commit 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1
and v2") from Dec 18, 2025 (linux-next), leads to the following
Smatch static checker warning:

	kernel/cgroup/cpuset-v1.c:641 cpuset1_generate_sched_domains()
	warn: duplicate check 'root_load_balance' (previous on line 618)

kernel/cgroup/cpuset-v1.c
    596 int cpuset1_generate_sched_domains(cpumask_var_t **domains,
    597                         struct sched_domain_attr **attributes)
    598 {
    599         struct cpuset *cp;        /* top-down scan of cpusets */
    600         struct cpuset **csa;        /* array of all cpuset ptrs */
    601         int csn;                /* how many cpuset ptrs in csa so far */
    602         int i, j;                /* indices for partition finding loops */
    603         cpumask_var_t *doms;        /* resulting partition; i.e. sched domains */
    604         struct sched_domain_attr *dattr;  /* attributes for custom domains */
    605         int ndoms = 0;                /* number of sched domains in result */
    606         int nslot;                /* next empty doms[] struct cpumask slot */
    607         struct cgroup_subsys_state *pos_css;
    608         bool root_load_balance = is_sched_load_balance(&top_cpuset);
    609         int nslot_update;
    610 
    611         lockdep_assert_cpuset_lock_held();
    612 
    613         doms = NULL;
    614         dattr = NULL;
    615         csa = NULL;
    616 
    617         /* Special case for the 99% of systems with one, full, sched domain */
    618         if (root_load_balance) {
    619                 ndoms = 1;
    620                 doms = alloc_sched_domains(ndoms);
    621                 if (!doms)
    622                         goto done;
    623 
    624                 dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
    625                 if (dattr) {
    626                         *dattr = SD_ATTR_INIT;
    627                         update_domain_attr_tree(dattr, &top_cpuset);
    628                 }
    629                 cpumask_and(doms[0], top_cpuset.effective_cpus,
    630                             housekeeping_cpumask(HK_TYPE_DOMAIN));
    631 
    632                 goto done;

If root_load_balance is true we are done.

    633         }
    634 
    635         csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
    636         if (!csa)
    637                 goto done;
    638         csn = 0;
    639 
    640         rcu_read_lock();
--> 641         if (root_load_balance)
    642                 csa[csn++] = &top_cpuset;

Dead code.

regards,
dan carpenter

    643         cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
    644                 if (cp == &top_cpuset)
    645                         continue;
    646 
    647                 /*
    648                  * Continue traversing beyond @cp iff @cp has some CPUs and
    649                  * isn't load balancing.  The former is obvious.  The
    650                  * latter: All child cpusets contain a subset of the
    651                  * parent's cpus, so just skip them, and then we call
    652                  * update_domain_attr_tree() to calc relax_domain_level of
    653                  * the corresponding sched domain.
    654                  */
    655                 if (!cpumask_empty(cp->cpus_allowed) &&
    656                     !(is_sched_load_balance(cp) &&
    657                       cpumask_intersects(cp->cpus_allowed,
    658                                          housekeeping_cpumask(HK_TYPE_DOMAIN))))
    659                         continue;
    660 
    661                 if (is_sched_load_balance(cp) &&
    662                     !cpumask_empty(cp->effective_cpus))
    663                         csa[csn++] = cp;
    664 
    665                 /* skip @cp's subtree */
    666                 pos_css = css_rightmost_descendant(pos_css);
    667                 continue;
    668         }
    669         rcu_read_unlock();
    670 
    671         for (i = 0; i < csn; i++)
    672                 uf_node_init(&csa[i]->node);
    673 
    674         /* Merge overlapping cpusets */
    675         for (i = 0; i < csn; i++) {
    676                 for (j = i + 1; j < csn; j++) {
    677                         if (cpusets_overlap(csa[i], csa[j]))
    678                                 uf_union(&csa[i]->node, &csa[j]->node);
    679                 }
    680         }
    681 
    682         /* Count the total number of domains */
    683         for (i = 0; i < csn; i++) {
    684                 if (uf_find(&csa[i]->node) == &csa[i]->node)
    685                         ndoms++;
    686         }
    687 
    688         /*
    689          * Now we know how many domains to create.
    690          * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
    691          */
    692         doms = alloc_sched_domains(ndoms);
    693         if (!doms)
    694                 goto done;
    695 
    696         /*
    697          * The rest of the code, including the scheduler, can deal with
    698          * dattr==NULL case. No need to abort if alloc fails.
    699          */
    700         dattr = kmalloc_array(ndoms, sizeof(struct sched_domain_attr),
    701                               GFP_KERNEL);
    702 
    703         for (nslot = 0, i = 0; i < csn; i++) {
    704                 nslot_update = 0;
    705                 for (j = i; j < csn; j++) {
    706                         if (uf_find(&csa[j]->node) == &csa[i]->node) {
    707                                 struct cpumask *dp = doms[nslot];
    708 
    709                                 if (i == j) {
    710                                         nslot_update = 1;
    711                                         cpumask_clear(dp);
    712                                         if (dattr)
    713                                                 *(dattr + nslot) = SD_ATTR_INIT;
    714                                 }
    715                                 cpumask_or(dp, dp, csa[j]->effective_cpus);
    716                                 cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
    717                                 if (dattr)
    718                                         update_domain_attr_tree(dattr + nslot, csa[j]);
    719                         }
    720                 }
    721                 if (nslot_update)
    722                         nslot++;
    723         }
    724         BUG_ON(nslot != ndoms);
    725 
    726 done:
    727         kfree(csa);
    728 
    729         /*
    730          * Fallback to the default domain if kmalloc() failed.
    731          * See comments in partition_sched_domains().
    732          */
    733         if (doms == NULL)
    734                 ndoms = 1;
    735 
    736         *domains    = doms;
    737         *attributes = dattr;
    738         return ndoms;
    739 }


