Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8E9009A
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfHPLSa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 07:18:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfHPLSa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Aug 2019 07:18:30 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyaFS-0008PI-Qe; Fri, 16 Aug 2019 13:18:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de
Subject: [PATCH 0/4] cgroup: spinlock_t vs raw_spinlock_t cleanup
Date:   Fri, 16 Aug 2019 13:18:13 +0200
Message-Id: <20190816111817.834-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

spin_lock_irq() disables interrupts as part of the locking process on
!RT but does not disable interrupts on RT. Therefore in the sequence
	spin_lock_irq(a)
	raw_spin_lock(b)

will not acquire lock b with disabled interrupts.
While looking into fixing cgroup_rstat_flush_locked() for RT I came up
with the following series.

Sebastian

