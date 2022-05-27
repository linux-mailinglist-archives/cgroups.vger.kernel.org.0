Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B078535BE7
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiE0Isr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiE0Isq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 04:48:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA33BF9C;
        Fri, 27 May 2022 01:48:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q4so3572892plr.11;
        Fri, 27 May 2022 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/TuFldqNWvbTR7kMknQ2sKjIOSGzhXUVTHp1Dts3Bw=;
        b=Waerq1Kg5SvqcLdZ91WgRWzCShy7ZEJw5Th3INevO7MYiKqxU166flLRKYb6F3n2WE
         +/jhiCUpHLjXscO+mQm+qzYfcQ6QVGscfz94TDWbs+505PMsEP+VLtuM0nmfmnKsORsx
         e2rNwgY0TNH0ff4YJnyjGYKYCKLwXdHus/fT3gypmPcIAeRq3baIiEb27H10uQWXYWfr
         86WDeESm08ae9QxBJNHTwBk5pwNcblO1VibwZ1AnB5yigJm8+lsU84fszGAC0X4wtRRI
         3kHnhOT13M7HHIjATivsUNe1oExErxDO5MThHSnlAo+zQhu7ZP6+XxwioyoBbQaf/HJZ
         NFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=F/TuFldqNWvbTR7kMknQ2sKjIOSGzhXUVTHp1Dts3Bw=;
        b=V8g66Om94JDOy3U2U+66WDF/nKz9hK1KIUOrVnoAzNWWvpm49FRFX+SXVADuYmUS2i
         EtZP3RpXv+zhlReOdsCXbJVviIoKSlnF65OGs118F5ek1GrQf83jOtv/xai8qhgFWm1Z
         G5RAIoZHavRch5GAVfChoJ+0N10U+VppByBhoJ1tRzc5zOIuCmeg0fp2YmYHphTmpQbB
         XrUCUL6Fs+YX7gGF3bxIBpsVibLG4B9r7WO5tq8tJphdyUD2euy4/HTvlTUBLhW5T/y+
         mSxhv2gVfmltMJAykF6Wdf8UyYDtHlq6m4lLHDX1IeeGhz63y3b9xAXVTd69+4+WNGGl
         b+kA==
X-Gm-Message-State: AOAM531UB3jazNMgi+/H0wW471n+ifP7xbKtdw4NtK3sNQ77XIlk77lK
        73Ib3G4D0TzjWixwFLepcA8=
X-Google-Smtp-Source: ABdhPJwqtjzGV0uG1WoBE3y9BQjc+1acwVdSs33qFdDUPmDyP1NaqwM6CP6aSD4H6E3KNP5tm3n0Yw==
X-Received: by 2002:a17:902:7781:b0:161:c85a:8fff with SMTP id o1-20020a170902778100b00161c85a8fffmr42066123pll.97.1653641321290;
        Fri, 27 May 2022 01:48:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ac0e])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b0050dc7628137sm3002469pfo.17.2022.05.27.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:48:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 22:48:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
Message-ID: <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
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

On Fri, May 27, 2022 at 10:39:18AM +0800, Hongchen Zhang wrote:
> when remove a cgroup dir, make sure all the csses associated which
> the cgroup are all offlined,so that we will be sure that the resources
> allocated by the csses are all freed when rmdir exit successfully.

Offlining doesn't guarantee that resources are freed and there's no definite
time limit on how long it'd take to free all resources. e.g. for memcg, if
there isn't sufficient memory pressure, its page cache can remain
indefinitely. Is there something practical you're trying to achieve?

Thanks.

-- 
tejun
