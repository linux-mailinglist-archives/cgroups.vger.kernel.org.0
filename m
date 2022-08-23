Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAFE59EC69
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiHWTeU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHWTdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:33:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13760137195
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 11:27:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so18038297pjj.4
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=+WvRv1MoYZ7sQiK7t+GyZ70lGFaAzp9tw2tlccfkvmk=;
        b=pCNYuN0qV52Vx7RAFA8Tjg3Hz2xw7hy2GFRZk03BroITwWpspQ7kVFl8GnZiNZYwj0
         6C+RyprsHjGX+lB/VB448WO6TPXxcTCz8IQpmcewZ+5X7hrEH/mw/4vqw4BWqkDc6FwA
         OnedAe+4BAqfBX66VcLX4VQ3mk0DDHXK62gsv2WXu76Rh1Vxd5BUkHkWob8uVYX3ss+s
         2KrYSA6S9db5oVTTEotHhuRx3PgK4/XNXr5Jg90SB8QO5BDvINKA1Y6A+8/993IWlez2
         qeWGAT7VZiCib09D/F47cQay89J7W8T/fmqFCYwj6jSnRGLYHKswyNcMxRfYb/lHcFJu
         Pqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=+WvRv1MoYZ7sQiK7t+GyZ70lGFaAzp9tw2tlccfkvmk=;
        b=WJP8BHh5uDbCSOWmBAFtj5cPn96Cou/yRE/hSwApFwmscZPtcPdgshcdezha6Rx+m/
         dn0q3QnhjaPtNyooXLFhkywCuW+ifqPitXZoZdCv0h2GHR017vl0qFYkgKr/heEhtuG8
         cAfLjMLPvID0QZ/pQkj1pBKpr9ADoF49zvTAo/ifJti20oJ7tZmoaIi0//vtpVhT+msJ
         +Cyva9zqhYMfL0Nn97/viEMZf04YN0Jvhi0cfzXRrcZyo7LE60yFlrKuh2cH67Y4QcJ5
         cgyBvt8ImEv58HOMBYvONqUyaKtL1wQmYdvu0uxkK34w+ifriqDtjrGo5YdfsHpwK3ro
         vDaA==
X-Gm-Message-State: ACgBeo2yF0wTxEs2wGdU737x7rzR1yrzgBe2gUezv0dXmlqwoyqgnbTw
        yQ/mGTDgd6H0PkxepqVUrRgwam8KzoU=
X-Google-Smtp-Source: AA6agR5h2wRhzo6Q+mixovyI4lDL4caVETpTtrwMwCxWjqwxGi4KkWHgwqxPYazlI6g6Ki1NuJOeFw==
X-Received: by 2002:a17:902:e548:b0:172:aafb:4927 with SMTP id n8-20020a170902e54800b00172aafb4927mr26251458plf.106.1661279260406;
        Tue, 23 Aug 2022 11:27:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b00172bd7505e6sm9271326pln.12.2022.08.23.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:27:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:27:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Message-ID: <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
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

(cc'ing Johannes for visibility)

On Fri, Aug 19, 2022 at 10:51:27PM -0400, Chris Murphy wrote:
> Hi,
> 
> Tracking a downstream bug in Fedora Rawhide testing, where 6.0-rc1 has landed, and we're seeing various GNOME components getting kllled off by systemd-oomd, with the stats showing suspiciously high values:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2119518
> 
> e.g.
> 
> Killed /user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.Shell@wayland.service due to memory pressure for /user.slice/user-1000.slice/user@1000.service being 27925460729.27% > 50.00% for > 20s with reclaim activity
> 
> I'm not seeing evidence of high memory pressure in /proc/pressure though, whereas oomd is reporting really high memory pressure and absolute time for it that makes no sense at all:
> 
> >>Sep 09 03:01:05 fedora systemd-oomd[604]:                 Pressure: Avg10: 1255260529528.42 Avg60: 325612.68 Avg300: 757127258245.62 Total: 2month 4w 2d 8h 15min 12s
> 
> It's been up for about 2 minutes at this point, not 3 months.
> 
> Thanks,
> 
> 
> --
> Chris Murphy Murphy

-- 
tejun
