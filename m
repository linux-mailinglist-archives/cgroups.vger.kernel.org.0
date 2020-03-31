Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E09199A55
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgCaPxA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 11:53:00 -0400
Received: from verein.lst.de ([213.95.11.211]:39171 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbgCaPxA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 31 Mar 2020 11:53:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6158468BFE; Tue, 31 Mar 2020 17:52:57 +0200 (CEST)
Date:   Tue, 31 Mar 2020 17:52:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Weiping Zhang <zwp10758@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
Message-ID: <20200331155257.GA22994@lst.de>
References: <cover.1580786525.git.zhangweiping@didiglobal.com> <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com> <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com> <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com> <20200331143635.GS162390@mtj.duckdns.org> <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com> <20200331155139.GT162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331155139.GT162390@mtj.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 31, 2020 at 11:51:39AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 31, 2020 at 11:47:41PM +0800, Weiping Zhang wrote:
> > Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
> > dedicated interface
> > like /dev/xxx or /proc/xxx?
> 
> Yes, something along that line. Given that it's nvme specific, it'd be best if
> the interface reflects that too - e.g. through a file under
> /sys/block/nvme*/device/. Jens, Christoph, what do you guys think?

I'm pretty sure I voiced my opinion before - I think the NVMe WRR
queueing concept is completely broken and I do not thing we should
support it at all.
