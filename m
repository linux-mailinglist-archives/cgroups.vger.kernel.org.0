Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A182774633E
	for <lists+cgroups@lfdr.de>; Mon,  3 Jul 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGCTS7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jul 2023 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGCTS6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jul 2023 15:18:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DC3B3;
        Mon,  3 Jul 2023 12:18:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2633b669f5fso2500835a91.2;
        Mon, 03 Jul 2023 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688411937; x=1691003937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLM8bt3vqZ21jspV7McGNog/5FNdcWiwVX6Q2kETF+w=;
        b=fUp8/gUM2xrq39W+clwmjDIYDsuV+SZhqcNG+rHtVRX2tfH41iYLXpznD8T4D3LlP+
         CIcoe+/xpdIEbFUCGm+70brdCsfacfSTyYM8SJuASzxma8g4ZZbVtN1cwysy8XlfiebM
         Cl+tGytgq2mJ5HObmp/lIiGcc9InwR8pdcXW9gkVgWYD+pXigazeoBmsdFMt0xOIGrjf
         +Y+4hWetaYbNk+llbwBKHyAb54yRyVDAF0APffUVdna6RS1vVuFrySrytVYYT0/rl/Vo
         gRufkceyPoNuelB1zZ+rNf9dxN8Zrqv8w/G8UQWZ1CjOezy/GsFN1Idn1pcYiBhiEl6R
         weyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411937; x=1691003937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLM8bt3vqZ21jspV7McGNog/5FNdcWiwVX6Q2kETF+w=;
        b=dZiZIu6v24N94j+X3fcpNKRgwMexkTvYZPGiF0pUU9FJ/XzX2ppknmhfsNy1aOLgT0
         VdVZ3rf9t9pqArarmVM0XJUkfja0h0hc3G0TdOWOKG4KdGftLY5Bxkc8xPzB3eFZu34I
         AKNN/9Sei0RU6aswH0d/TbMeSLzTe0XnnPGRmnokcxsnAK6lVgDPEX91HPK1tKnBMnrY
         ccCP419Pc9oHL8dV31Fnu3Y36sPqISthLnRzIIcyxIGi422qQ4TPei4mx1+aStrrXp+6
         78rRNwEdyVmrAN/Md2IlYL0TbFhxGqhwBzEYJCmbB7NUGm3ChgbWA267QIgyuMOP3w7X
         TKBg==
X-Gm-Message-State: ABy/qLawDPZGr6z9l7WpNJTeEe7aA6ZhhqmnEyMRARBx2mZT0jQzlARL
        owG28sPHxpdazKFrG4CoCj8=
X-Google-Smtp-Source: APBJJlEgkiH2hxhC6f5fcPZdglZe3aagEtuAzDRm7nJGvp39jQ/SmVb1jsWIB4BdcShVa5aNz1E1Og==
X-Received: by 2002:a17:90a:1a0c:b0:262:fba5:2a8e with SMTP id 12-20020a17090a1a0c00b00262fba52a8emr9636232pjk.47.1688411937172;
        Mon, 03 Jul 2023 12:18:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b0b9])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b00263dccf96a3sm449059pjh.54.2023.07.03.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:18:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Jul 2023 09:18:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Message-ID: <ZKMfHtY6zYFWvdqA@slm.duckdns.org>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <9244d968-b25a-066f-2ff3-1281bf03983e@redhat.com>
 <a6c55b82-71eb-ad18-e4b2-d62f1102a0e4@redhat.com>
 <53486caa-8ca7-78f5-71ac-d5692b482c94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53486caa-8ca7-78f5-71ac-d5692b482c94@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 03, 2023 at 10:58:19AM +0800, Miaohe Lin wrote:
> On 2023/7/2 7:46, Waiman Long wrote:
> > On 7/1/23 19:38, Waiman Long wrote:
> >> On 7/1/23 02:50, Miaohe Lin wrote:
> >>> update_parent_subparts_cpumask() is called outside RCU read-side critical
> >>> section without holding extra css refcnt of cp. In theroy, cp could be
> >>> freed at any time. Holding extra css refcnt to ensure cp is valid while
> >>> updating parent subparts cpumask.
> >>>
> >>> Fixes: d7c8142d5a55 ("cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule")
> >>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>> ---
> >>>   kernel/cgroup/cpuset.c | 3 +++
> >>>   1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> >>> index 58e6f18f01c1..632a9986d5de 100644
> >>> --- a/kernel/cgroup/cpuset.c
> >>> +++ b/kernel/cgroup/cpuset.c
> >>> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> >>>           cpuset_for_each_child(cp, css, parent)
> >>>               if (is_partition_valid(cp) &&
> >>>                   cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
> >>> +                if (!css_tryget_online(&cp->css))
> >>> +                    continue;
> >>>                   rcu_read_unlock();
> >>>                   update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
> >>>                   rcu_read_lock();
> >>> +                css_put(&cp->css);
> >>>               }
> >>>           rcu_read_unlock();
> >>>           retval = 0;
> >>
> >> Thanks for finding that. It looks good to me.
> >>
> >> Reviewed-by: Waiman Long <longman@redhat.com>
> > 
> > Though, I will say that an offline cpuset cannot be a valid partition root. So it is not really a problem. For correctness sake and consistency with other similar code, I am in favor of getting it merged.
> 
> Yes, cpuset_mutex will prevent cpuset from being offline while update cpumask. And as you mentioned, this patch makes code more consistency at least.

Can you update the patch description to note that this isn't required for
correctness?

Thanks.

-- 
tejun
