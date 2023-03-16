Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FBE6BD85E
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 19:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCPSxN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Mar 2023 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPSxM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Mar 2023 14:53:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD064108E
        for <cgroups@vger.kernel.org>; Thu, 16 Mar 2023 11:53:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s8so1625346pfk.5
        for <cgroups@vger.kernel.org>; Thu, 16 Mar 2023 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678992790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1W/YlEcuttY3U+vH0Zvi8N5CN0MRI21GzH8QWAyVcI=;
        b=Lat+lKQfUS8qaHdbgQZoN+LZJ35jZBofHf93jeA469v8V8xyILhxZ+ts9CUZjkmXG4
         BbOsppMk1ngvHvYqHcCR8mIv1Ai6oqZ0J82FEJaLC7Jw5+YnuB86WMQq76w5MdLh/hsV
         xnUwyu2dXI2LCGJXqS424ufkp3xGGJAbtKYKOQmSQhDwW1JAqJt3Rpg+EzFHFkPZXFdH
         cqVf30QcR/9JUr0XM1+OT4Z0QBBo7OV8m+HCyQGbdr/t+5TGOKhEooqc26/y6FP1R0pw
         k7g9H+qG/GeBUhVNf9fAqrS8yCyfH/ZH7aVRbTPn2QIPARVF3t6WP7325CEJl5rRB9Ek
         nGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678992790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1W/YlEcuttY3U+vH0Zvi8N5CN0MRI21GzH8QWAyVcI=;
        b=W33qXQZH1ssUzwruDlBScgeVO4AidYdF9SlOM9Gw6zAnRRCChP2Ry12MaIfdILWK0o
         OJ+DUjAzLGyKhOiW1FCLOYiARN20R+1D/OOln1TTInfeKHVjhLNJW5ho7vj9fg+CNbZL
         NKgQFu43SvyUCVj6z6E7ThjXK/JIS9ZohmmDzw3jHRFf8gvbKCrO3OBHrkvcYt7FG0JU
         +4r90hKJk6D6VutDIkzHK8IB/q5wnHhnTyseTJvWv1bdTmewBjtHObbLPYmK9cwzgEzb
         mVDLoO9aeszMSXWxhni+Tq+WzUUMkvx1QDUYDea4pI1gyh5EXdql9bpdnzUEJLEjyB2J
         dn1g==
X-Gm-Message-State: AO0yUKVrNDLVnzrRk2ahEj8M4xg83/p8SW9WNmpstbAVfZAErZM2AZbn
        UncQmIQ6Je7MuRxvAG++FMtjKyNTcKxFSzCxCJGxFw==
X-Google-Smtp-Source: AK7set8calzpmt4TbvcPrwDLOE09bCWglEjTwqJL2dcv5Oh96AwzuzFYFuH3zOn+uAZGWnv7FxksYI8VP/RxjpVrANE=
X-Received: by 2002:a65:6d96:0:b0:503:2583:effb with SMTP id
 bc22-20020a656d96000000b005032583effbmr1174594pgb.9.1678992790072; Thu, 16
 Mar 2023 11:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230315214029.899573-1-joshdon@google.com> <bfbdef64-1b8c-4168-2576-f6d4a112686b@redhat.com>
In-Reply-To: <bfbdef64-1b8c-4168-2576-f6d4a112686b@redhat.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 16 Mar 2023 11:52:58 -0700
Message-ID: <CABk29NuKPJAVFCJ=i2Qh4=UqPoj5aia01-mCiF3p8vebV3uPWg@mail.gmail.com>
Subject: Re: [PATCH] cgroup: fix display of forceidle time at root
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 15, 2023 at 7:19=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> How about adding the following fixes tag?
>
> Fixes: 1fcf54deb767 ("sched/core: add forced idle accounting for cgroups"=
)

SGTM, thanks Waiman!
