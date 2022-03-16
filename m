Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57584DB655
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiCPQjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357477AbiCPQjx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 12:39:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC30220DB
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 09:38:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so5516834pjb.3
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJG9d+Kapo0GF7vwtS3fr/dHSRbCdMx6tPdBaWiajKU=;
        b=VnlKOwXeu1JbtWgHXg66/LRudlGjGdd4KwAhx7lqYYr5HZ0xPz5SaCNHNxthx3PODH
         plbWZ8WTaBn9EWpsQLJaYl/HJ3BDuZILWyi/rf70/f6UERAvjfHCTLaI18y7jv3P4hZ6
         nVBdsAyFDA5dC/k1DQyF/TEcDArR8pazwZiQgEH6UU9OgX+wrlsGHe/6OlsJn8rk5zMf
         2rn875loP+m4YQjUmX2h4azPligyPoTeG8Zw5+GtJ/7KmjH+Y74Y/1Afkf124kFRCC9B
         sXaAKfJJMA1EwW2MoJa2fSKc4D0uRnvQ7cJZCfzraMbEVRutC/KUIC4MuNCPl4jUydwY
         QwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KJG9d+Kapo0GF7vwtS3fr/dHSRbCdMx6tPdBaWiajKU=;
        b=epBEdnqgiDfGJAlAXS1xl9L84r0tU4DGjNwP+Hm1264e0Aqs1/aNcbFnboBC7vuX5C
         Kg4Zr5G5NyVywJ/H1UeTg9/9z5zL5vdG3oT8EILWNmNARtxf5nTowzu7Ksc0QybAYfsI
         5CTUQD8x79qFahKUgh8w/nG5l+J0AMYTm88wNyEcmLV/Ut7UKh7gS7SxNsd+lNZhZWPL
         uLVUWoI5kKiCc1XOyyH2y66IoB5vtDiiAXl7VZXFh+5PMhtvw2i190klqHiAf9mpMftb
         VTJ7fYueLfwzn+abTmuu3SVA3X/rr3aGVmn6uVYxVvjHKZzi9DNvY+Z5wShP/N0s1+eP
         R2fg==
X-Gm-Message-State: AOAM531u92EqAOoZkzMqh1x+aAak1+OgqA/4S6fCd+bYTPEPgibe4KN6
        bbUGOqDY6/RVW+vdhx3vqmc=
X-Google-Smtp-Source: ABdhPJxc8W/nE+n1xPyRqTo6cZuxvW0h+BniQiXRFHCQrCidG405hdq888+4tNKTT+hqZXabszMC2g==
X-Received: by 2002:a17:902:ecc2:b0:151:dd64:c77a with SMTP id a2-20020a170902ecc200b00151dd64c77amr508471plh.154.1647448710548;
        Wed, 16 Mar 2022 09:38:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mq6-20020a17090b380600b001c6357f146csm7207387pjb.12.2022.03.16.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 09:38:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Mar 2022 06:38:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: Split process across multiple schedulers?
Message-ID: <YjIShE3mwRyNbO53@slm.duckdns.org>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
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

On Mon, Mar 14, 2022 at 03:19:56PM +0000, Olsson John wrote:
> Preferably for optimal performance you want to isolate the cores where the virtual core threads are running so nothing else interferes with them (besides kernel threads connected to IRQs that can't be moved from the isolated cores). The VMM is then running on another core that is not running a virtual core thread. CGroups is the preferred way of accomplishing this. :)

I have a basic question. cgroup provides new capabilities through its
ability to hierarchically organize workloads on the system and distributes
resources across the hierarchy. If all one wants to do is affining specific
threads to specific CPUs or changing some other attributes of them, there's
nothing extra that cgroup provides compared to using plain per-task
interface. Is there some other eason why cgroup is the preferred way here?

Thanks.

-- 
tejun
