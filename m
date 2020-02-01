Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8A14F754
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2020 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgBAJJB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Feb 2020 04:09:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBAJJB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Feb 2020 04:09:01 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixold-0003oU-V5; Sat, 01 Feb 2020 10:08:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7F0CE103088; Sat,  1 Feb 2020 10:08:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        edmund.nadolski@intel.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous affinity set
In-Reply-To: <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
References: <cover.1580211965.git.zhangweiping@didiglobal.com> <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
Date:   Sat, 01 Feb 2020 10:08:36 +0100
Message-ID: <871rrevfmz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Weiping Zhang <zhangweiping@didiglobal.com> writes:

> nvme driver will add 4 sets for supporting NVMe weighted round robin,
> and some of these sets may be empty(depends on user configuration),
> so each particular set is assigned one static index for avoiding the
> management trouble, then the empty set will be been by
> irq_create_affinity_masks().

What's the point of an empty interrupt set in the first place? This does
not make sense and smells like a really bad hack.

Can you please explain in detail why this is required and why it
actually makes sense?

Thanks,

        tglx
