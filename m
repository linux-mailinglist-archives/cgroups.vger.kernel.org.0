Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511B59ED59
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiHWUeH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiHWUdw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 16:33:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC34DB77
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 13:12:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo18280234pjd.3
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=5P2IYFXnBuqEEpc4CpdxE08u3EYHqSr7NM2nRc/y1Cs=;
        b=piey8fd81RjOiCoeeNAbIC9004Ti19DiEvR3H3xP2IKRlfMGEiQErifqfbBA4Imq0Q
         STVuCTaeYOQNB7IKOUYmxIPWKX42dEChsCUUvSIVp10G4WgCmpX+BZ2DWXNpM85E7Mxf
         bH0VtQ2YJZJfNZ1kHoyOqTOWJToEyXUgJpPhP2NbIoOicyZejil30mCzfHfwg51M+e2n
         SaWQrRjOUdy+qjYQSu5TP/HNwmGzBwDmKNRRr95C1NOobQZ4miB2kOQR5NjdwsRFf7Sx
         Bm7SlDajcKzynKbQR9H8fGWH6nPkO/XmlL4iohsSNyg+zBBIH2KO06UWw7F22QKSA5fX
         fAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=5P2IYFXnBuqEEpc4CpdxE08u3EYHqSr7NM2nRc/y1Cs=;
        b=ZJrQaKAihg45SpBMHBiIGCN7YbrQVFC1YuoHr8q77n1YaTleMw2feSYAnpljht+Gc3
         eGViUJN37+d24IlZ4xJdnEZ3GnluvyylhDbmCpaivCX8o7l9h+ihwjmVN0XdGqa7lvwb
         7QU+2Agt08h2ZDoyi21gEhTjAz9nuKqGKcn9/cEvAFk3qDT1xhS4NvMSgv1djdKEVdwa
         qK1x7YsqAv65i3BmykOUwVgQ5fggEvsZ/a1MdOEtu9uWMxf4UidWgzggEYMGnjplZ6Np
         Hs+zqRgtXowG+SjISakX8GZZgqY3WPMCvYpuZi3pH0fCtYKaeCTNfRshorHeXSzWHEYj
         jOIw==
X-Gm-Message-State: ACgBeo0PIgIX16svmQ4fjIL5KF9YlHPVulBuniGRPcI9os1EzfTgVXY7
        1BoHk7krfH8APXC0d9mwoSA=
X-Google-Smtp-Source: AA6agR5ehd/KwECDovbewatV1oUUKYmbrTw42CiWkV58Kii4XwThww4ZGUbVg1HXqYejjHIU/h2Scw==
X-Received: by 2002:a17:903:40c7:b0:173:a1a:3646 with SMTP id t7-20020a17090340c700b001730a1a3646mr2619874pld.18.1661285530936;
        Tue, 23 Aug 2022 13:12:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id a12-20020aa794ac000000b00536873f23dfsm5498998pfl.136.2022.08.23.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:12:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 10:12:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Message-ID: <YwU0mLBMuxpZ7Zwq@slm.duckdns.org>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
 <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
 <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
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

On Tue, Aug 23, 2022 at 02:59:29PM -0400, Chris Murphy wrote:
> Same VM but a different boot:
> 
> Excerpts:
> 
> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:some avg10=3031575.41 avg60=56713935870.67 avg300=624837039080.83 total=18446621498826359
> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:full avg10=3031575.41 avg60=56713935870.80 avg300=624837039080.99 total=16045481047390973
> 
> None of that seems possible.
> 
> io is also affected:
> 
> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.SettingsDaemon.Smartcard.service/io.pressure:full avg10=0.00 avg60=0.13 avg300=626490311370.87 total=16045481047397307
> 
> # oomctl
> # grep -R . /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/
> https://drive.google.com/file/d/1JoUxjQ2ribDvn5jmydCWXJdg0daaNScG/view?usp=sharing
> 
> We're going to try reverting 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56 and see if it helps.

Can you see whether the following helps?

Thanks.

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ec66b40bdd40..00d62681ea6a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,7 +957,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
+	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
 	if (!cgroup->psi)
 		return -ENOMEM;
 
