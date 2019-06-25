Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60A52359
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 08:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfFYGOS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jun 2019 02:14:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfFYGOS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jun 2019 02:14:18 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfei9-0005PW-9o; Tue, 25 Jun 2019 08:13:45 +0200
Date:   Tue, 25 Jun 2019 08:13:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
In-Reply-To: <20190625021411.GD23777@ming.t460p>
Message-ID: <alpine.DEB.2.21.1906250811150.32342@nanos.tec.linutronix.de>
References: <cover.1561385989.git.zhangweiping@didiglobal.com> <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com> <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de> <20190625021411.GD23777@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

MIng,

On Tue, 25 Jun 2019, Ming Lei wrote:
> On Mon, Jun 24, 2019 at 05:42:39PM +0200, Thomas Gleixner wrote:
> > On Mon, 24 Jun 2019, Weiping Zhang wrote:
> > 
> > > The driver may implement multiple affinity set, and some of
> > > are empty, for this case we just skip them.
> > 
> > Why? What's the point of creating empty sets? Just because is not a real
> > good justification.
> 
> Patch 5 will add 4 new sets for supporting NVMe's weighted round robin
> arbitration. It can be a headache to manage so many irq sets(now the total
> sets can become 6) dynamically since size of anyone in the new 4 sets can
> be zero, so each particular set is assigned one static index for avoiding
> the management trouble, then empty set will be seen by
> irq_create_affinity_masks().
> 
> So looks skipping the empty set makes sense because the API will become
> easier to use than before.

That makes sense, but at least some of that information wants to be in the
change log and not some uninformative description of what the patch does.

I was not Cc'ed on the rest of the patches so I had exactly zero context.

Thanks,

	tglx
