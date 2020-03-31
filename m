Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC821998AC
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgCaOgj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 10:36:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38800 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgCaOgj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 10:36:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id z12so18476367qtq.5;
        Tue, 31 Mar 2020 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8eJTubDOpnYx+MtqM441enT6egVrVa4bYoBdzCqVy0=;
        b=VWvb+6VE6Bc3z/zRovKdw8FPguqnvnIL0uwajhY5uXtucaCe7G5c85lThPb8hTYhn9
         PHL8UjRnU/deAljnmmbMJgW8hSM1swVCyNW2OW6VVgfDQlYLeOzIN1ms85bXnrPLVjfp
         gURscr2MPffBwbRimGGc39gyNwgkkPSUHcXIpF981uDN/xVlURsl2L+jZJHEP9Q6N2/U
         0RmjKDv3e33dDDCV6KBvznLJ9FFRCF2gp7g8UX6Ot84jVjOCu1VjPLF4rq4xCRpxW6/m
         xc+sGYdo5GiXmo7cVGmvFQ5PPwcti5+DYPEvSt181iW17IaYwwGdANqpdxCjzS8sEHn/
         kPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g8eJTubDOpnYx+MtqM441enT6egVrVa4bYoBdzCqVy0=;
        b=p2z33e1X1QCWg5UJcJ40p32az7HmOhhQ+krihBHODRsU2eqFNsCGBMVaDsV/mkgEJ5
         69U2R+Syu+LcNT+plViFjguW+TcrXVhBdjK+ZBI2kAT6yNkKbg2P+czlhUPAwSRncy89
         b7dk0T/mGQ3KSLHuQdHfPQfWHaZ9ERJqvNHnK0aJwA1EuM9wNguhK1SEyakUzbOnPhCm
         d8SsGCldVUiBBG1dhpuW2XpgdOYQ4+Fj48XIYjHBOmGDG+Q+5tntbZh7m8qeyQoJRBRP
         VnBoLE1q+m7w/vHLE2egKUTzKk7g8bBHbp7iViQ0zev5xabRa1a8sDozSmyr0yahgCqY
         B/Ag==
X-Gm-Message-State: ANhLgQ2DW9W0fRrSD84kpIuzawy4gLTBBy2BW4mgcaB82bWgqX6Ox+mT
        cY5H4Kzze666ma2zUqvXVQg=
X-Google-Smtp-Source: ADFU+vuHaX3R0Rod/OfU4HzywP3xMCDKTEorvnNns5X0xjYEKqcjXzXOibbmborAYzSd8CwlUgvZ7g==
X-Received: by 2002:aed:3c10:: with SMTP id t16mr5340804qte.45.1585665397860;
        Tue, 31 Mar 2020 07:36:37 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id 199sm12602372qkm.7.2020.03.31.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:36:37 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:36:35 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20200331143635.GS162390@mtj.duckdns.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Weiping.

On Tue, Mar 31, 2020 at 02:17:06PM +0800, Weiping Zhang wrote:
> Recently I do some cgroup io weight testing,
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
> I think a proper io weight policy
> should consider high weight cgroup's iops, latency and also take whole
> disk's throughput
> into account, that is to say, the policy should do more carfully trade
> off between cgroup's
> IO performance and whole disk's throughput. I know one policy cannot
> do all things perfectly,
> but from the test result nvme-wrr can work well.

That's w/o iocost QoS targets configured, right? iocost should be able to
achieve similar results as wrr with QoS configured.

> From the following test result, nvme-wrr work well for both cgroup's
> latency, iops, and whole
> disk's throughput.

As I wrote before, the issues I see with wrr are the followings.

* Hardware dependent. Some will work ok or even fantastic. Many others will do
  horribly.

* Lack of configuration granularity. We can't configure it granular enough to
  serve hierarchical configuration.

* Likely not a huge problem with the deep QD of nvmes but lack of queue depth
  control can lead to loss of latency control and thus loss of protection for
  low concurrency workloads when pitched against workloads which can saturate
  QD.

All that said, given the feature is available, I don't see any reason to not
allow to use it, but I don't think it fits the cgroup interface model given the
hardware dependency and coarse granularity. For these cases, I think the right
thing to do is using cgroups to provide tagging information - ie. build a
dedicated interface which takes cgroup fd or ino as the tag and associate
configurations that way. There already are other use cases which use cgroup this
way (e.g. perf).

Thanks.

-- 
tejun
