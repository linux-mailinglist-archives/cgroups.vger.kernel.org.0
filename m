Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100FE517A0
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfFXPuW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 11:50:22 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43091 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfFXPuV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 11:50:21 -0400
Received: by mail-ot1-f45.google.com with SMTP id i8so6864671oth.10
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2019 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8myhvq178LDUl7I4FoNI+Lu1VTlerrD1c45aJYqC8NU=;
        b=PUNk8yovZHbXkBBep/263tf6wYeTeUwWG1Nm+qCEz55Lk74D7Um6Q/3MRiSppY2Yxx
         h8fbYzz0b6kwTpKv4XPL8ixLfKbD2xQkZ7SG5yfmhSKG7h2AtyxZaoyzDV/Er9tzjy4w
         dEphCN+uJPMoyODXqPInVyJ33blp2WrB0yQuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8myhvq178LDUl7I4FoNI+Lu1VTlerrD1c45aJYqC8NU=;
        b=r5KGCJ6UaHH+ohYosKhMe53/8R1KpmI6i+S5yW0KLyHC7Fs/fh5A7eARumGec4rzzM
         fnvrbvztXmMinKKUxdGCe7AcFo/1+3NGVSReOE0chqP1m7Tn+F77n+Y2W/f7AypLcjHC
         YRNT4fnwGhQZMuTZtH0IWSZmvEfKpuRyX6irfSbbvtHX/GrtTnkNiucTSmsdGYwCLg/h
         L75m+UWzJqP4j0T8eo1Mt+hok+1Rymg7FeGQXXb4TIJEGza5RLVxLQjq4UI+Xmo/v2bj
         yuDWaxkype8YSU2lsVkV9cjuinoI5CUkcHkOcZwlJ+SulA/FEmcEQKs6+iaI9jVQGLsQ
         uhVQ==
X-Gm-Message-State: APjAAAV8VjHYT7+dYSmFpCynljHDj/t2hg/i1uOzJ3olXj518mtiRc/3
        ZUGanV/YglmfObqGCVTFC6piUrUNGGBIkw==
X-Google-Smtp-Source: APXvYqzbMD+f7wzKYiZDRTmef5MK5GFoBYRdjfKDopr15+02mn84uuFdvhoh59tR4YOB9jZpwPbYXQ==
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr48237869otf.137.1561391420731;
        Mon, 24 Jun 2019 08:50:20 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id x88sm4237710ota.56.2019.06.24.08.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:50:19 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: 
Date:   Mon, 24 Jun 2019 10:50:03 -0500
Message-Id: <1561391404-14450-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Changelog v4
 - Rewrote patch to return all quota when cfs_b has very litte.
 - Removed documentation changes, as bursting is no longer possible with this
   new solution.

After the suggestion from Ben Segall to set min_cfs_rq_runtime=0, I came up
this in an attempt to balance the desire leave runtime on the per-cpu queues
with the desire to use this quota on other per-cpu rq.

Basically we now check the cfs_b on each return, and decide if all the remaining
time should be returned or to leave min_cfs_rq_runtime on the per-cpu queue
based on how much time is remaining on the cfs_b.  As a result this mostly
gives us the benefits of both worlds.

