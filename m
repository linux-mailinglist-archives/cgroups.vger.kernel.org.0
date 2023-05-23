Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247E70CFEE
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 03:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjEWBAo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 May 2023 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjEWBAO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 May 2023 21:00:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CBF4;
        Mon, 22 May 2023 17:58:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so47434515ad.0;
        Mon, 22 May 2023 17:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684803466; x=1687395466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1yeqEL2YFpMCthAHwog2p9ezUJQgAe4nd/8yOnzMLc=;
        b=mKHau8NZ3Yfh1+Dl1mZTJ3fMqlAxuzxBvZBEcbcRmB+4MXlsrHFZxRkkSVizIiOk+2
         884tLTyi8cz3TFoBQOYDx7LyT1Cin+4VQSM6mebUsRyzPQS4/tEnm8ETaOu1a+rTHKQG
         ccvvmWNKW7FBJCpZ9ltt4n3kl+5lhEm9qSDVme3umGX9Q95ekxoN7PKRosfVZCtaUbK8
         EADZsG7lRqZ1ykzwADZT6gC6+1A8Db6ayB3WAhGTmtMT5bCPoXCwIaMpaMYCAgOr6GSP
         ormBpu2Wmxp4YXUXlpkjeheAy3sVKuF1wQrdwl+9iSYF5fVOrj6Lz5/nZ4TBuY5TjgPO
         td7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684803466; x=1687395466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1yeqEL2YFpMCthAHwog2p9ezUJQgAe4nd/8yOnzMLc=;
        b=CwoC3GYxCScjvVFY92v7+hd/fX6/K2EQDk8p/LVk3BimA4aAi1AoLNhI1flD4lbWPp
         Kt4UfX04DMyDDHeWtTN34b56V5ugCDiBYfM6buUnZU/tZNMzamNqVSHukLMoBlyUw2Q6
         Jcf06DjVfhQfBwBBPl/VcgJS3PATyXrWjP/SFHrFFTHq4kq/IsDJ13vZLtbKevgjnyn/
         sxTQpJ2oYwitXFu9wUNfeMRVPx/1wa3BAfo4bD5qv3hQoVyjLkTZ7ZQ33xrtt6mPYjjd
         7lgq9NRguYh7mwdnWVOVvheWbicLMd+/d9fgKTxF1AEZZOhYqlRYnzijnY2Z0id0M5O3
         dzRw==
X-Gm-Message-State: AC+VfDy/q1BuWatP7QX4xKAejQrtev+HFlAR4mPxpu13J+911loobyk6
        2JIeACyx+hKYRbM2bl5nmVs=
X-Google-Smtp-Source: ACHHUZ6kMl5/PXrFASjEZtGrJSoUco4dItV83+U06SvBQ2QSIyK+0CqZR4t8vjgCMyoxVVVwEIMO+Q==
X-Received: by 2002:a17:902:ce8a:b0:1af:cbe4:d953 with SMTP id f10-20020a170902ce8a00b001afcbe4d953mr654888plg.60.1684803466050;
        Mon, 22 May 2023 17:57:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090341c500b001aae909cfbbsm5409544ple.119.2023.05.22.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:57:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 14:57:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: always put cset in cgroup_css_set_put_fork
Message-ID: <ZGwPhzm_Eh2Bx-5v@slm.duckdns.org>
References: <20230521192953.229715-1-jsperbeck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521192953.229715-1-jsperbeck@google.com>
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

On Sun, May 21, 2023 at 07:29:53PM +0000, John Sperbeck wrote:
> A successful call to cgroup_css_set_fork() will always have taken
> a ref on kargs->cset (regardless of CLONE_INTO_CGROUP), so always
> do a corresponding put in cgroup_css_set_put_fork().
> 
> Without this, a cset and its contained css structures will be
> leaked for some fork failures.  The following script reproduces
> the leak for a fork failure due to exceeding pids.max in the
> pids controller.  A similar thing can happen if we jump to the
> bad_fork_cancel_cgroup label in copy_process().
> 
> [ -z "$1" ] && echo "Usage $0 pids-root" && exit 1
> PID_ROOT=$1
> CGROUP=$PID_ROOT/foo
> 
> [ -e $CGROUP ] && rmdir -f $CGROUP
> mkdir $CGROUP
> echo 5 > $CGROUP/pids.max
> echo $$ > $CGROUP/cgroup.procs
> 
> fork_bomb()
> {
> 	set -e
> 	for i in $(seq 10); do
> 		/bin/sleep 3600 &
> 	done
> }
> 
> (fork_bomb) &
> wait
> echo $$ > $PID_ROOT/cgroup.procs
> kill $(cat $CGROUP/cgroup.procs)
> rmdir $CGROUP
> 
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Applied to cgroup/for-6.4-fixes w/ stable cc'd.

Thanks.

-- 
tejun
