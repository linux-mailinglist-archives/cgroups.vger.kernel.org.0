Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC617C2AB
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2019 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfGaND2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Jul 2019 09:03:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729373AbfGaND2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Jul 2019 09:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C416DAEF3;
        Wed, 31 Jul 2019 13:03:26 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:03:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
Subject: Re: No memory reclaim while reaching MemoryHigh
Message-ID: <20190731130325.GO9330@dhcp22.suse.cz>
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725140117.GC3582@dhcp22.suse.cz>
 <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
 <20190726074557.GF6142@dhcp22.suse.cz>
 <d205c7a1-30c4-e26c-7e9c-debc431b5ada@profihost.ag>
 <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
 <57de9aed-2eab-b842-4ca9-a5ec8fbf358a@profihost.ag>
 <8051474f-3a1c-76ee-68fa-46ec684acdb6@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8051474f-3a1c-76ee-68fa-46ec684acdb6@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-07-19 09:45:00, Stefan Priebe - Profihost AG wrote:
> Sorry for may be spamming - i try to share as much information as i can:
> 
> The difference varnish between my is that:
> * varnish cgroup consumes active_anon type of mem
> * my test consumes inactive_file type of mem
> 
> both get freed by drop_caches but active_anon does not get freed by
> triggering memoryhigh.

Do you have swap available?
-- 
Michal Hocko
SUSE Labs
