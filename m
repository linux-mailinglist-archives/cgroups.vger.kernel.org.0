Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804CF58DD71
	for <lists+cgroups@lfdr.de>; Tue,  9 Aug 2022 19:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiHIRsa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRs3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 13:48:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188B635E;
        Tue,  9 Aug 2022 10:48:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso18359083pjq.4;
        Tue, 09 Aug 2022 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/XUPB7pFtOYoycuDFEn5/QlUZ8HX8U8F4NCHS3GlZ7g=;
        b=dOcme2W1j/Uj3R0nK4UZMD3vQw2hi9QP65Jf9hr81ak1O5nQdws8mUGWTL8HQdc+gg
         UWconUCrj6/RmOCE0LuNalZirs5SvMS145tEpaAzf14sSPs9cSP7Emus3F69WuxT11Z+
         +wmLOudmwzEVGJAqPsf4GyM1LWDbAVIeJniXeFhztGunhkV1LAggp/q5CDteqJdMNlDR
         TsJtPdNNK5LAkqSFNl0y1F4R5BMzxNO434/qEF2a0/lCjQ5Z+MV/lt5KFCYCZM2PdpCQ
         Qm62LlwZGKWPuyxRTnq7xne4qYO14uTvxkoMYfmewxkRLH1UlJX0yJ4pTKmih1/QLOWG
         5ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/XUPB7pFtOYoycuDFEn5/QlUZ8HX8U8F4NCHS3GlZ7g=;
        b=QqqVrvJd7kfUYXFD+zoA8YpMOGku+4+frzZgVGPoZY6sqRH3MDAjrOZyIMYc5EE69Y
         d+8jpCCPBPmsI4bSo79VaUlR9W8jg7UAgn/+8geZenpdk8Mxws/1oLbfO1QfPQjGv+Us
         84sXs0hqp2zhTPLFs5NgOjOBc/oI8GaHGbxH+4ZT96apwlQ5uvGo/U54KFJtODEN7oZM
         /K84/5ZgVJtPxXIwA/JADyICpz5+FROgdvbGBtvBOHdLCft1u1ieGZcdlVgAsDvsaP2K
         IVs6QeKPPk7wYkWsplHSPTJEJE7oZMQf2z7iYHmOpACUx80sPzKfGiSAJrBAMsV3Hkyj
         cvXw==
X-Gm-Message-State: ACgBeo2g2XcxN6XpJzyIU4axNGR+Aw2FaGByBdllRU6w9ExfpMtqXcSY
        6ac3DaQsE1cqbJ8nH3SSim8=
X-Google-Smtp-Source: AA6agR5rgqGJDdVh/5DK/qc+gV56D025O/2vstyB0D9SKdUXgl+arABd2dSm9QcsI356Hy/ocAx6bA==
X-Received: by 2002:a17:902:bb91:b0:16c:3f7f:6df0 with SMTP id m17-20020a170902bb9100b0016c3f7f6df0mr24546601pls.99.1660067307290;
        Tue, 09 Aug 2022 10:48:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 194-20020a6216cb000000b005286124df03sm183346pfw.87.2022.08.09.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:48:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Aug 2022 07:48:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YvKd6dezPM6UxfD/@slm.duckdns.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808110341.15799-10-zhouchengming@bytedance.com>
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

On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
> So this patch introduce a per-cgroup PSI stats disable/re-enable
> interface "cgroup.psi", which is a read-write single value file that
> allowed values are "0" and "1", the defaults is "1" so per-cgroup
> PSI stats is enabled by default.

Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
"cgroup.psi" is the best name. Also, it doesn't convey that it's the
enable/disable knob. I think it needs a better name.

Thanks.

-- 
tejun
