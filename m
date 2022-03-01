Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F04C8B71
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiCAMWf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiCAMWe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 07:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919398AE7E
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 04:21:51 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646137309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfddx/bqOMx3W9SlOR1eV+6FO/n1Opg1b6CVpO7RL7U=;
        b=dH3gc34djkt0JOaEehitHKfAQ6UxHeq1XLssCuubQJART03xrydbVUtpnAxI7LBMnG+VHZ
        J/TjcE46TjDEM9mFU/0RpA4M5lKvNIFte+Cm8mAGMig/AAHqZUzWXjYophVj0O9z6lL+8B
        bVpzt+at4d3PBsSBPkiSygwOa7JV47G7tIl89VOCBTeMrIIJ6R7v1dB7CxA+ALOn/0UEYG
        1cSYWXK5c7/SlJEfEB+nTrL6634T6/Gt5v2ZJLoYNYdYinq/HCF9RukglWmbG4I8Z+/0DU
        pM5yruTEVGRZAO3Wf8KjCBH72dNX7bDAiw97Butu0GOYC+rIeQXj+hXekWZxCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646137309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfddx/bqOMx3W9SlOR1eV+6FO/n1Opg1b6CVpO7RL7U=;
        b=9g/BuBmjt4a/GaxqqsQlg4bC/W7sglkZ2vsEPR4BjMCLMFfKrOiveSi5di8X/iHnI9rVFe
        ff5w7sLSZ4G4JbDQ==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: 
Date:   Tue,  1 Mar 2022 13:21:41 +0100
Message-Id: <20220301122143.1521823-1-bigeasy@linutronix.de>
In-Reply-To: <[PATCH 0/2] Correct locking assumption on PREEMPT_RT>
References: <[PATCH 0/2] Correct locking assumption on PREEMPT_RT>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This mini series address the last two PREEMPT_RT problems left:
- spin_lock_irq() vs raw_spin_lock_irq() (#1)
- irqs_disabled() check which is not working because interrupts are not
  disabled (#2)

Sebastian

