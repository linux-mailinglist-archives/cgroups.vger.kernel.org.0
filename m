Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84476FB0E
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 09:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDH2h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHDH2g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 03:28:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD24F3AA6
        for <cgroups@vger.kernel.org>; Fri,  4 Aug 2023 00:28:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso10904455e9.0
        for <cgroups@vger.kernel.org>; Fri, 04 Aug 2023 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691134113; x=1691738913;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VN2JACKxsZL/oUKnyCvyLes64DwlVzVTXFWkesuh998=;
        b=L0SSutuIButkgx7B2hwYEsoFYQRqzePnpoUcsvkEogpnk4axGu+CANlTsXct/0w7w6
         vGVPRfQI2zySJrfSq59X9Pff5QxXzsG0FRrtccAXB5K5YKxKrxosL9rOHP/24Tudi8R0
         NraKJJnd6oM0NTM64WWSGHr3Xw5MkzG4VhqWzc/tQiZsyANEu/SU6rCtArJcZN1S1no3
         0kRXdiLqpg/iO1CKxjEp1BrJO2xPElybfM6kr0ux/hte2UATKGP/bzjc3yXgdOvaS3Mm
         3RdOd3lkk/HUUhmn2YqK+BbEP1Z7hCJgKQceRGdPXwwLm/JFZcpybljD6LPtRGTpebef
         qJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691134113; x=1691738913;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VN2JACKxsZL/oUKnyCvyLes64DwlVzVTXFWkesuh998=;
        b=b1Hg9452lujxrR8jaghrAUoOEfA8+ZXA+q7r3heyufgxQ33KZ2aw8aPcQSAvMVnqqH
         lm7s0lFM25mRIWsPuZQbx2J5B2adtDH6tYB6LlQl+chX6Nx4Mb+KqtxFlc75D98llVvF
         jnn9iyIzrqKN9y4iZFvNwn/rF4/yELwELvaHOAwivkSfy0PMhD2fOjVocHbNWBZe+eyt
         nlPfGmH8s0HWIpO2soyCLPGL45b+dHoN8DqSNsORfQjf2nhBrBujMMgRovVNTdYmGi6U
         BgnTVZxp2oQcXnRS+2cxyapET3Zpgevi5kxtwtf6HdrP5Zh6Lellz9w5KWhu9acAyPRF
         bNGw==
X-Gm-Message-State: AOJu0YxkwNIvsV9f6L6NHkEk3cwF/UlLHllePv/nEGJa4WHk1CK2hn/d
        wvzDFIws1X/XsRD5vlGbFv7a1UEtDF5QvfPZgGk=
X-Google-Smtp-Source: AGHT+IGPZdNk3Xcvu9oX3+J5sIu14oNMGKs0YbOJa2ALAv3JgnTCORdFHeaJbhOYQE4LLXi/ARhaBw==
X-Received: by 2002:a05:600c:5025:b0:3fe:2677:ebe with SMTP id n37-20020a05600c502500b003fe26770ebemr832446wmr.10.1691134113323;
        Fri, 04 Aug 2023 00:28:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l17-20020a1ced11000000b003fbcf032c55sm5969230wmh.7.2023.08.04.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:28:32 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:28:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     bigeasy@linutronix.de
Cc:     cgroups@vger.kernel.org
Subject: [bug report] cgroup: use irqsave in cgroup_rstat_flush_locked().
Message-ID: <39c0d51f-eae4-4895-8913-a290bba27d78@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Sebastian Andrzej Siewior,

The patch b1e2c8df0f00: "cgroup: use irqsave in
cgroup_rstat_flush_locked()." from Mar 23, 2022 (linux-next), leads
to the following Smatch static checker warning:

	kernel/cgroup/rstat.c:212 cgroup_rstat_flush_locked()
	warn: mixing irqsave and irq

kernel/cgroup/rstat.c
    174 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
    175         __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
    176 {
    177         int cpu;
    178 
    179         lockdep_assert_held(&cgroup_rstat_lock);
    180 
    181         for_each_possible_cpu(cpu) {
    182                 raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
    183                                                        cpu);
    184                 struct cgroup *pos = NULL;
    185                 unsigned long flags;
    186 
    187                 /*
    188                  * The _irqsave() is needed because cgroup_rstat_lock is
    189                  * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
    190                  * this lock with the _irq() suffix only disables interrupts on
    191                  * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
    192                  * interrupts on both configurations. The _irqsave() ensures
    193                  * that interrupts are always disabled and later restored.
    194                  */
    195                 raw_spin_lock_irqsave(cpu_lock, flags);

There is obviously a giant comment explaining why irqsave is required
instead of irq.

    196                 while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
    197                         struct cgroup_subsys_state *css;
    198 
    199                         cgroup_base_stat_flush(pos, cpu);
    200                         bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
    201 
    202                         rcu_read_lock();
    203                         list_for_each_entry_rcu(css, &pos->rstat_css_list,
    204                                                 rstat_css_node)
    205                                 css->ss->css_rstat_flush(css, cpu);
    206                         rcu_read_unlock();
    207                 }
    208                 raw_spin_unlock_irqrestore(cpu_lock, flags);
    209 
    210                 /* play nice and yield if necessary */
    211                 if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
--> 212                         spin_unlock_irq(&cgroup_rstat_lock);

But it's sort of confusing that irqsave isn't used here.  It's so
weird that irq doesn't disable interrupts on some configs where _irqsave
does.  That seems like the naming is bad.

    213                         if (!cond_resched())
    214                                 cpu_relax();
    215                         spin_lock_irq(&cgroup_rstat_lock);
    216                 }
    217         }
    218 }

regards,
dan carpenter
