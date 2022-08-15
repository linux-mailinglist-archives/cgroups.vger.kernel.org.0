Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5859450A
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 00:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbiHOWiO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 18:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350817AbiHOWhL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 18:37:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5681306AC;
        Mon, 15 Aug 2022 12:50:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so7235408plr.8;
        Mon, 15 Aug 2022 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Di1CBe/l3lFU1XEMEHMD/NMLKrrpGfsfoqHbgdL41rY=;
        b=JuMvrFxcpiKSsluaG1sm5UeOdp2pC3giGOS2OG59Y//fuQbFRfELDeH/pCcBIswiDf
         lZAf9nK/Y2R/Slxxx4YUgrO+F12ef80ywTcQLYTu8qeuofUcBPT7wsZnHVA+pr4+0/Cj
         2tUC4IQVIStZaEDFenvFjtb8mmfyzTXMYIyz/i28Sb2IcML8EkxfwWRAP/3mhdWUdJG5
         VVHotdeDOBc2ap2gYTcc16AbrAOrCJwUGwpW0kqck33YQQZ/msYuYMqPoV3dfpYUAbdG
         l7XZwTBXqp8itTZ6ESNEpnA/05+OnSneaC/vjjcsmmudVYim9hPHM6KvxdLxnmzlWVOM
         Qjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Di1CBe/l3lFU1XEMEHMD/NMLKrrpGfsfoqHbgdL41rY=;
        b=1SfrJUrADimY6sR5KcE/VuHa6d+C7K3gPr+r+TpiByTeV268iEsn0bk/q4/Mh8YhD1
         jBEE0+ZaRwhZotL9vEDR+W9F+m+zf6sjhkgjeqZG1ROb3pJZ62lcrDXtO3rLGv97vD8k
         K2uT8RsIM5MDkf3dRf9Q1k7lTi66xYb8zPzt38tOVyChsDcQsghw8LBpAjFz7fVlonWj
         Hdg4AaQAWQTjWKSlSIg/7CUTDY689NnodX0fZijDipTEWSiy2oNV0Dq3AkP8ubNoSJl1
         b9JM0i8XVSDLBVOu6MH6bVGFQHzGc5hs0xdBDy8l5n8xBU4aP8q+6doLa76nrRl2gMDA
         zlvg==
X-Gm-Message-State: ACgBeo3twqA0ZIOefX3L9duv83XT54z8qr2i0Gm31Cj52JXAK2smUQ6X
        0dzwEkGp7D2UYAe101pxxaE=
X-Google-Smtp-Source: AA6agR4R1QdI6pW/aafCRuGM/0QFfLfWgDKOb+nYbwM1XcyQTAJaJsWfdgHpO+kUWsnlfWUBKtOq6A==
X-Received: by 2002:a17:902:8f8a:b0:170:8df4:eebd with SMTP id z10-20020a1709028f8a00b001708df4eebdmr18681986plo.116.1660593032457;
        Mon, 15 Aug 2022 12:50:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b0016c06a10861sm7351319plk.74.2022.08.15.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:50:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 09:50:30 -1000
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
Message-ID: <YvqjhqJQi2J8RG3X@slm.duckdns.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvprI6ZL8dVWGyBO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvprI6ZL8dVWGyBO@cmpxchg.org>
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

On Mon, Aug 15, 2022 at 11:49:55AM -0400, Johannes Weiner wrote:
> I think it should also add/remove the pressure files when enabling and
> disabling the aggregation, since their contents would be stale and
> misleading.
> 
> Take a look at cgroup_add_dfl_cftypes() and cgroup_rm_cftypes()

The problem with adding cftypes dynamically is that it can fail, which isn't
the end of the world here but still kinda sucks. I think what we actually
wanna do is hiding and unhiding while keeping all the data structures in
place which is needed somewhere else anyway.

Thanks.

-- 
tejun
