Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0407A42546E
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhJGNlV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 09:41:21 -0400
Received: from submit01.uniweb.no ([5.249.227.132]:33869 "EHLO
        submit01.uniweb.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbhJGNlN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 09:41:13 -0400
Received: from [10.20.0.41] (helo=mail.uniweb.no)
        by submit01.uniweb.no with esmtpa (Exim 4.93)
        (envelope-from <odin@digitalgarden.no>)
        id 1mYTcD-00BKLK-LV; Thu, 07 Oct 2021 15:39:17 +0200
Date:   Thu, 7 Oct 2021 15:39:16 +0200
From:   Odin Hultgren van der Horst <odin@digitalgarden.no>
To:     tj@kernel.org
Cc:     cgroups@vger.kernel.org
Subject: Re: Re: [Question] io cgroup subsystem threaded support
Message-ID: <20211007133916.mgk6qb65d2r57fc2@T580.localdomain>
References: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> The biggest is the fact that page cache pagse are owned by processes not
> threads. A related issue is that writeback tracks ownership per inode with a
> mechanism for transferring ownership when majority writer changes. Splitting
> IO control per-thread would increase friction there. So, the summary is that
> the kernel doesn't track related resource consumptions at thread
> granularity.

So mainly the writeback functionality or is it ingrained in all
functionality like latency and priority?

If not, is there a subset of io cgroup subsys that could easily support threading?

And if so, could one either split the subsystem into two subsystems a
io_threaded and io or possibly add an option to disable the functionality
that restricts it from supporting threading?

Thanks.
--
Odin
