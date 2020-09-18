Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5C26EA0E
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIRApB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRApA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3FC06174A;
        Thu, 17 Sep 2020 17:45:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so1999846qvb.12;
        Thu, 17 Sep 2020 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4g8oZaM4I1PTgkVQKRiJNIBO3rGE09QsJ8U+iD020Q=;
        b=oqR+7x5dJyQcBEwZDtu1PVnUg0zlf4DCuy1Zp8tZ2FigjcnKMuj2pg78JL2AbnBQLM
         lpNqq/FRqu/ytyo8P0ug/B0NXdeHsnftsBfGkIM6w01ef/dTfOFlrd8uvz0wYDofxW2j
         XG2W1jvJ1QCpUQjZYlT3L7Y/KLFvXTba2Foj+z6KNYngQWofDOXSMuS9OfxiwO+OkcXo
         ngQeOqW5OMDzeAazkPzJ+x3uqMA5U3+dI26Nu8OaD8VY+C0DSbIWFjjQuaQDxENVb17v
         W8e68mbdDldx+0xBYRKbuIFe5WVgXpXmEniOLKGUU2XkHCRJE3SDflzZRT653J+gyPdT
         yMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=I4g8oZaM4I1PTgkVQKRiJNIBO3rGE09QsJ8U+iD020Q=;
        b=fij2JfqxIU0h0hqxh6f/kLhTL6TkLLCjJ6pOdO4ucbSi4EEOJVdFep57EYqYDpwp+q
         ApvMaY536ZVJYnzJIooW8ucKQNm+VAtm86WEUGoz+W5+uPyAdGyp6AbPMdJ3pyDk1sqe
         gL7ddc08sPloEkNYfKjI2UJoR/rw4OqkfPF5KYx+g2rMidN/E739a2KOEN/e/orWDCGy
         QpD2YkuEPlwydHc198Py5lhgSbynDL42UYDYUPEBFDg5cB98b/9IBtLlA8EOegVm3cH8
         /jiwncANM8VYcbAXtZxqdOWYJmkeDtq9QKgPGPuyTSIzduIFeM3DR35njjKBdB06GPkx
         D/Fw==
X-Gm-Message-State: AOAM531FvIYP3qK4FJ6SXQKZFMSt4/oPl/nuD7c4q1slT4zf4MOHkPAR
        ca0CA1SBz2OqHq63TC2OZnBHtQNtLCeJiQ==
X-Google-Smtp-Source: ABdhPJyn2pmKBLJDKQFFGWpimDyrVIFq6Efh5yAXczEBVLkltpvJg6VKFJcu0xaZIpkehLhIddMH3Q==
X-Received: by 2002:ad4:4594:: with SMTP id x20mr31706024qvu.4.1600389899750;
        Thu, 17 Sep 2020 17:44:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id v131sm1064791qkb.15.2020.09.17.17.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:44:59 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCHSET for-5.10/block] iocost: improve debt forgiveness logic
Date:   Thu, 17 Sep 2020 20:44:51 -0400
Message-Id: <20200918004456.593983-1-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Debt reduction logic was recently added by dda1315f1853 ("blk-iocost: halve
debts if device stays idle"). While it was effective at avoiding
pathological cases where some iocgs were kept delayed while the device was
most idle, it wasn't very effective at addressing more complex conditions
and could leave low priority cgroups unnecessarily harshly throttled under
moderate load.

This patchset improves the debt forgiveness logic so that it's more
effective at reducing such unnecessary throttling. This patchset contains
the following five patches:

 0001-iocost-factor-out-ioc_forgive_debts.patch
 0002-iocost-replace-nr_shortages-cond-in-ioc_forgive_debt.patch
 0003-iocost-recalculate-delay-after-debt-reduction.patch
 0004-iocost-reimplement-debt-forgiveness-using-average-us.patch
 0005-iocost-add-iocg_forgive_debt-tracepoint.patch

and is also available in the following git tree:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-debt-forgiveness

diffstat follows. Thanks.

 block/blk-iocost.c            |  141 +++++++++++++++++++++++++++++-------------
 include/trace/events/iocost.h |   41 ++++++++++++
 2 files changed, 141 insertions(+), 41 deletions(-)

--
tejun

