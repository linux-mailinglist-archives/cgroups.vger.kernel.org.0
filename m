Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB857EC2F
	for <lists+cgroups@lfdr.de>; Sat, 23 Jul 2022 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGWFMN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Jul 2022 01:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWFMN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Jul 2022 01:12:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40683796BA;
        Fri, 22 Jul 2022 22:12:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y24so6119616plh.7;
        Fri, 22 Jul 2022 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQfcrjLQfJsHyJARxdU3O2zsQqRoNOwqh6fsHaYV9SA=;
        b=WD63DTaXf4JL2gAONMBONT0m5CXaWi5ga05M8g23sp9GgXRD4ohr4/mB9b5nyuKjVU
         9/voD4gn+EsXbKbNZ9GixOR/zzQw0i6b5CMeeEHM8bAn90lsiBxnK58nTttW8U88/q4T
         SUZE+IuFRbR7XlLpa5KAySMiHGQhNdY661OhQBnNTvwTDTet2/o3eP0gZPU+IIEXVbOx
         hGTnippenOJiJkAdOJfN30E26pDGRdb1MrfndfSDxMyA4TpSa1EFcO5l46SQCLFZB9we
         kOFpvKQVAMzQykhPDydAvQ8yE2P9Uzpajju0qpp0fI1qOphFUzXGaeqA+XSQyw1z9B2w
         EbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vQfcrjLQfJsHyJARxdU3O2zsQqRoNOwqh6fsHaYV9SA=;
        b=CXZLPcuJuUN1lNHX+uh98JXFWunQMfbUPJ4wlF5eDUz3jrFsTiTh7Z6Vsx9xNhlGig
         FVrLvZL6sRotANG5b3lwefAb4gyf1zDJ9HcH85U6qNMmzvZRxkBaWJG8QQ7ZPaAtWtvG
         cIeMn2NFvdtLwOTRqL+NczoRO0gcRybflFIgqlC6fBmHrwHkJUTH+HvmyUdphkwvrCOW
         aLCSjnJHRHEPPb3EsNRh0vbs90GVDkpTieA3PV0nZJ91X0i+Pl0NU9yPuV55D4eWns7h
         ns4Endwri+I7PcVWquxTkx2uy/561XJikopkxB8mLo/MEVEZMGgz07vNNNdPkd5DJmMb
         lR8g==
X-Gm-Message-State: AJIora/gQ4s0Bqra7tzY/1NQsBxu6eDSDY7Kk23EA5NKqYXHvMHSePmm
        WfapHBDd8kSw63S8K6n/lCs=
X-Google-Smtp-Source: AGRyM1tTSorjYKZpsV+BcTjIZDgnVKAYMFfTyH4gjcPufnrFd3yYTmQLrLVT5LYrHh8ED1x0nDaQgw==
X-Received: by 2002:a17:902:d2d1:b0:16c:223e:a3db with SMTP id n17-20020a170902d2d100b0016c223ea3dbmr3153432plc.37.1658553130337;
        Fri, 22 Jul 2022 22:12:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:d97e])
        by smtp.gmail.com with ESMTPSA id 186-20020a6214c3000000b00525496442ccsm942023pfu.216.2022.07.22.22.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 22:12:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Jul 2022 19:12:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <YtuDJ7DijEEy3PfS@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applying 1-3 to cgroup/for-5.20.

Thanks.

-- 
tejun
