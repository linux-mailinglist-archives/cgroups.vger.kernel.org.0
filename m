Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72FF7C6FA0
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbjJLNsX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347289AbjJLNsW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 09:48:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E991C6
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:48:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso621778a12.2
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697118500; x=1697723300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6LAtbmR8nPZulMVNVlGlT005qfp9ySsIt46rwUK2ts=;
        b=zP1STZSIHnpOLc7q5GiaC2hIsDbUNNWiybGdJzZ1YuUk2iL+bDXXoTVjQpD/rvoreY
         oijm4VhmigG8lGXeX/OW22Itzgz8+7XtcVCfuP3aZH8d/1zoNDc2an5ddG0jExpwtBbR
         WMVy4njtHkmjtlfVG/StG1/DVet9sl0ncHlrBGo5wM6Bm4khRW50EnnDjVPlmiOtIgIe
         A2ijeO8njOy/0Rx+6R8/zSR3Q1CIwxBzmm+vhuOspzfXqpo1cwE2uCFd5mtwWKHNZvMN
         G/diCnP4VRFG/gvQ8rtybcgNLNrj8wcnegxFLlbRd8c5d99ya8Aaxq6jfIeIKlqpwv7l
         KDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118500; x=1697723300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6LAtbmR8nPZulMVNVlGlT005qfp9ySsIt46rwUK2ts=;
        b=AI7UoyzGphOE7PdSwrzgvK53LHiqQXNZ/lnYUirqDA9n3d5lM5pL0io0Glo/yE/Wpn
         BqBUQnXL2iiHUYD4udT+ffFZC85DWpUR03oE7uK10qivLFGLJXLEMIqRI7PqXhZnWnYn
         qfC5I/pBOhATmBi/p1FDIqy/vUkBO4nDvsQu5rHA3OV7MjqhWJMnndxdKspQMXDH8GqV
         OOGKZwu8dLH/hJ3ka0/aiY0OzgnuXZNJ38kv6DqAbqzH7KaDGmwn5ErB0asw+wYUMapW
         xpRMJbFHM2MQkIGxZwZ/7tbGVr/TZiHUx2qr5AWu+NkgX+UmI2SoPGnJvGCjJ9p/PM50
         Yjqw==
X-Gm-Message-State: AOJu0Yw4iCjw9bcgOCOSQqpPe+XVIRquGeC45T+i7rCO2KA9v4KPkMAK
        qodjQXkEdRHSHeKT1GKzClkni0ZO8cITXw==
X-Google-Smtp-Source: AGHT+IHI5jgd1c2oDlUjLraZPlJSkGAGErF45DQIm+sYXrCHbIRffp3LKnyIcwJ3misuhjuTpeOcKMFuqk/FfA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:4e4d:0:b0:589:86ae:2107 with SMTP id
 o13-20020a634e4d000000b0058986ae2107mr330554pgl.9.1697118500654; Thu, 12 Oct
 2023 06:48:20 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:48:18 +0000
In-Reply-To: <20231010000929.450702-6-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20231010000929.450702-1-roman.gushchin@linux.dev> <20231010000929.450702-6-roman.gushchin@linux.dev>
Message-ID: <20231012134818.737ack5hz76okmcy@google.com>
Subject: Re: [PATCH v2 5/5] percpu: scoped objcg protection
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 09, 2023 at 05:09:29PM -0700, Roman Gushchin wrote:
> Similar to slab and kmem, switch to a scope-based protection of the
> objcg pointer to avoid.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
