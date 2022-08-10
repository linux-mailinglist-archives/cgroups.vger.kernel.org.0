Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452CF58F18C
	for <lists+cgroups@lfdr.de>; Wed, 10 Aug 2022 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiHJR1R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Aug 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiHJR1Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Aug 2022 13:27:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EE7B1F6;
        Wed, 10 Aug 2022 10:27:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x10so14838237plb.3;
        Wed, 10 Aug 2022 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=lPqOojcmdOAU79rFEpjfZKvBUO43nFGE73fllT7UubM=;
        b=eyIMIlC3NT7t/M/JASfHlCFAM/ZU0pftD5lYftV9y52nfgtwB67ojBpqf2XsOJyPSE
         myoOkkToXgt6K3WrTFoFZsHIpdtUfS60IWEMULjtaEAE+TjV+RuhH4obNjaaAnckuTC6
         BA8od9MxEGi7eaZv3+xOdXOZnJG8xOpM61nKy+o20Apn56jqN9sCRN20JqYq4Pv+iw65
         HK2ViXVajAEPsYsQna5Rtt5YlPAEu3ZDWGIAtarHArRoEI4B1VFOHV8Y8a57Fcozd92H
         RiqaFV32hD0ryvy5JOdno8MAxtJFWUmXq0AKTETBfUdepAD+T8BmAmE4OsqE3afLYwij
         OsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=lPqOojcmdOAU79rFEpjfZKvBUO43nFGE73fllT7UubM=;
        b=pgvjHmGHgZhMPDKtnFCauGtCbSe+qrfsJjhO6+V2kL6tdrr7/5O8dGHzRBJVpvItV+
         KNB0pwOqDz61qtD4G0xA6op5ItDeTBHFwP8l3yMiJ7ulGEv+ip5ZgrZO0al0JmdNGF4L
         13ReKXjG7SYBllQgLbQXUr59LhuKrj+YSC6IqwiwUiZYjBpE2xzdcJ5UrvO57yVqLIex
         Q94CdudkDWvjSFff5ZcKyC461glMWq6vt5zN7T5Y4uVrC1ESVRQplgXPRAkKNDgDPBH+
         5cjffiCyXJIoYbnbNNQklstxvSpaf6onr65CANohzN+q8AcFKgMA0IMdEuJvZo0dF/yY
         FyyQ==
X-Gm-Message-State: ACgBeo1KAJKvQ1aK1Z8YkBd2jVBRQE8fwTnO8bJSgdc81wnjTbCwT6vp
        RD4A9ji+TTu3Bxvr/fncCHs=
X-Google-Smtp-Source: AA6agR6HimZCFCXcilZTgRuOlMb+mEEd0Usepl+nOvNphpTCT8ioe8FrPaDEA5NtEG5DEwW+MzXylg==
X-Received: by 2002:a17:903:230e:b0:16f:784:ea3f with SMTP id d14-20020a170903230e00b0016f0784ea3fmr28892311plh.160.1660152434248;
        Wed, 10 Aug 2022 10:27:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:237b])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a458c00b001f5513f6fb9sm1961423pjg.14.2022.08.10.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 10:27:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 Aug 2022 07:27:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YvPqcJh5Ffv4Yga9@slm.duckdns.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvPN07UlaPFAdlet@cmpxchg.org>
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

Hello,

On Wed, Aug 10, 2022 at 11:25:07AM -0400, Johannes Weiner wrote:
> How about just cgroup.pressure? Too ambiguous?
> 
> cgroup.pressure.enable sounds good to me too. Or, because it's
> default-enabled and that likely won't change, cgroup.pressure.disable.

.disable sounds more logical but I like .enable better for some reason. As
for just cgroup.pressure, yeah, maybe? The conundrum is that the prettiness
order is the exact reverse of the logical order. So, I'm okay with any of
the three.

Thanks.

-- 
tejun
