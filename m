Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCFC7BA8D1
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjJESMm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJESM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 14:12:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D690;
        Thu,  5 Oct 2023 11:12:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdf4752c3cso9202795ad.2;
        Thu, 05 Oct 2023 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696529547; x=1697134347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrVZ9ksg7P5W8XI53drIp4BTDrzYBAzM+oiMueHO5kk=;
        b=CZQFTr/Dup0QgIodnN0VoUM1rmTswhEEhtHcnysmQXGxtByZePOnSOp6bVVQ4f5dUW
         mLcHXCGXpgaLLQFPADg2cxjHx9fIaMv74WJ15k654ZmgEh/fqDHiE2AKHQcTwHi/MjCR
         m5ocdURtsGLmGtbXlRtTsYRUuafteEv03x0rQhBUxE9swZ3UeZRwdF84cEOzYzrDfAlN
         sBLmHEGgmsuQxgUhq4yefkOSx8hA3U7rIrv42CDgYtKSQK6ivHnd9WapIOYdsg1ubcak
         iAlL1BiubUBuChUpHipDTI3P3sdK7Y/R+F4e/4TnJrxJalsICiEdV6vwiwVayLw4PQwj
         j1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529547; x=1697134347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrVZ9ksg7P5W8XI53drIp4BTDrzYBAzM+oiMueHO5kk=;
        b=Io3XAeM9Am0q8x7WFBA9wAONxjNpTW3z0A34m7Ji7FAIeQgosz8pEKycLe6kr0di+y
         nKD8LjRxUDpaZiOAtsYgTXzL88X3mNVmt8TgNS6XnfBxVQBSGZOlAwcMaw9HI4K9ni6T
         xDfXk5zcJsOfpDkqGn1iv6Kjf+EGpJJwSf23CnhhCKEMFUuUaj5w4R6ep9Ri8K+cPSrZ
         M2Ry4730wQcOycF+3wD8WTu4CMUTAnWBwiSmRTTaoaRnCiT1X33W01vAYV6IRxOCwUBR
         sM/117rxQvxGU7QeRswZ9+MAfMHy10gCPrA5ow+EcjpxIFYSv9+la5HUCwIwaF8YNOlq
         D0Sg==
X-Gm-Message-State: AOJu0Ywpf25VzBzLfw4oIOY6r0JVCBDsO9AN08qnl3h1obSow0gMMR5S
        6BzPyAcOQWc6td9YL4R7LNN7zSP4ghvx7w==
X-Google-Smtp-Source: AGHT+IE8TNqgBjfKv4QBPtF0Yv+QLYEwlsjnHzsejdTgDSXyAa3xVzojhvHlZ8gXpK7zjeICSZ+8nw==
X-Received: by 2002:a17:902:edd0:b0:1c7:69a1:751e with SMTP id q16-20020a170902edd000b001c769a1751emr4681876plk.43.1696529547443;
        Thu, 05 Oct 2023 11:12:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001b9d95945afsm2025606plo.155.2023.10.05.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:12:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Oct 2023 08:12:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH] cgroup: In cgroup_no_v1() check v1
 controllers only
Message-ID: <ZR78iXWk-kTt4gf5@slm.duckdns.org>
References: <20230920102513.55772-1-kamalesh.babulal@oracle.com>
 <ZR26X4EJaNgQP5Be@slm.duckdns.org>
 <dc74f0ed-f647-cd1d-1bab-42366d2321b7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc74f0ed-f647-cd1d-1bab-42366d2321b7@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 05, 2023 at 04:51:52PM +0530, Kamalesh Babulal wrote:
> 
> 
> On 10/5/23 00:47, Tejun Heo wrote:
> > On Wed, Sep 20, 2023 at 03:55:12PM +0530, Kamalesh Babulal wrote:
> >> cgroup v1 or v2 or both controller names can be passed as arguments to
> >> the 'cgroup_no_v1' kernel parameter, though most of the controller's
> >> names are the same for both cgroup versions. This can be confusing when
> >> both versions are used interchangeably, i.e., passing cgroup_no_v1=io
> >>
> >> $ sudo dmesg |grep cgroup
> >> ...
> >> cgroup: Disabling io control group subsystem in v1 mounts
> >> cgroup: Disabled controller 'blkio'
> > 
> > So, making the printed names consistent makes sense but I'm not sure about
> > not matching "io" anymore. That's gonna break users who already use them,
> > right?
> 
> Agreed, users might pass "io" in place of "blkio", I was thinking
> in terms of cgroup v1 users, for whom it is "blkio" controller but
> as an argument, "cgroup_no_v1" makes the controllers passed to it,
> available under cgroup v2, where the controller is named "io",
> which the user may use interchangeably.
> 
> Shall I re-send the patch to print the controller legacy_name only?

Yes, let's do that.

Thanks.

-- 
tejun
