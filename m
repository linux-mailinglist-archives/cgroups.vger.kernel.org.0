Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C16BB356
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2019 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393767AbfIWMIa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Sep 2019 08:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391157AbfIWMIa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 23 Sep 2019 08:08:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E42F6AE00;
        Mon, 23 Sep 2019 12:08:28 +0000 (UTC)
Date:   Mon, 23 Sep 2019 14:08:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190923120828.GN6016@dhcp22.suse.cz>
References: <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
 <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
 <20190910132418.GC2063@dhcp22.suse.cz>
 <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
 <2fe81a9e-5d29-79cf-f747-c66ae35defd0@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe81a9e-5d29-79cf-f747-c66ae35defd0@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 19-09-19 12:21:15, Stefan Priebe - Profihost AG wrote:
[...]
> Which values should i collect now?

Collect the same tracepoints as in the past.

-- 
Michal Hocko
SUSE Labs
