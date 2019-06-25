Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28B65208D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfFYCOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 22:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfFYCOf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 Jun 2019 22:14:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C410B81F1B;
        Tue, 25 Jun 2019 02:14:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F3C600CD;
        Tue, 25 Jun 2019 02:14:17 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:14:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
Message-ID: <20190625021411.GD23777@ming.t460p>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
 <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 02:14:35 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Thomas,

On Mon, Jun 24, 2019 at 05:42:39PM +0200, Thomas Gleixner wrote:
> On Mon, 24 Jun 2019, Weiping Zhang wrote:
> 
> > The driver may implement multiple affinity set, and some of
> > are empty, for this case we just skip them.
> 
> Why? What's the point of creating empty sets? Just because is not a real
> good justification.

Patch 5 will add 4 new sets for supporting NVMe's weighted round robin
arbitration. It can be a headache to manage so many irq sets(now the total
sets can become 6) dynamically since size of anyone in the new 4 sets can
be zero, so each particular set is assigned one static index for avoiding
the management trouble, then empty set will be seen by
irq_create_affinity_masks().

So looks skipping the empty set makes sense because the API will become
easier to use than before.

Thanks,
Ming
