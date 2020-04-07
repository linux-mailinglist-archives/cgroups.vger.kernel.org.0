Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5A1A0E23
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2020 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgDGNHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Apr 2020 09:07:30 -0400
Received: from foss.arm.com ([217.140.110.172]:56134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDGNHa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 7 Apr 2020 09:07:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF0F031B;
        Tue,  7 Apr 2020 06:07:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF043F68F;
        Tue,  7 Apr 2020 06:07:28 -0700 (PDT)
Date:   Tue, 7 Apr 2020 14:07:26 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200407130725.jhtth3bneo33zex6@e107158-lin.cambridge.arm.com>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
 <20200403145523.GC162390@mtj.duckdns.org>
 <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
 <20200406143405.GH162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406143405.GH162390@mtj.duckdns.org>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/06/20 10:34, Tejun Heo wrote:
> On Mon, Apr 06, 2020 at 11:55:23AM +0100, Qais Yousef wrote:
> > What would be the right approach to get a fix in then? We have been skipping
> > this test for a while and we'd like to enable it but this failure is a
> > blocking issue.
> 
> Update the test so that it accounts for the async nature of the operation?

With a sleep() between the hp ops and the read? Isn't this a nasty hack?

I was just trying to find out what can be done for 5.7. But based on your
response this is sadly a dead end. For no reason I can comprehend.

--
Qais Yousef
