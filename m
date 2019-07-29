Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82C78475
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 07:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfG2FeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 01:34:15 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:61339 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbfG2FeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 01:34:15 -0400
Received: (qmail 19911 invoked from network); 29 Jul 2019 07:34:13 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.165]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 29 Jul 2019 07:34:13 +0200
Subject: Re: No memory reclaim while reaching MemoryHigh
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725140117.GC3582@dhcp22.suse.cz>
 <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
 <20190726074557.GF6142@dhcp22.suse.cz>
 <d205c7a1-30c4-e26c-7e9c-debc431b5ada@profihost.ag>
 <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
 <20190728213910.GA138427@chrisdown.name>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <2444c2d9-4c56-557a-5a25-c8ca25f94423@profihost.ag>
Date:   Mon, 29 Jul 2019 07:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728213910.GA138427@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chris,
Am 28.07.19 um 23:39 schrieb Chris Down:
> Hi Stefan,
> 
> Stefan Priebe - Profihost AG writes:
>> anon 8113229824
> 
> You mention this problem happens if you set memory.high to 6.5G, however
> in steady state your application is 8G.
This is a current memory.stat now i would test with memory.high set to
7.9 or 8G.

Last week it was at 6.5G

 What makes you think it (both
> its RSS and other shared resources like the page cache and other shared
> resources) can compress to 6.5G without memory thrashing?
If i issue echo 3 > drop_caches the usage always drops down to 5.8G


> I expect you're just setting memory.high so low that we end up having to
> constantly thrash the disk due to reclaim, from the evidence you presented.

This sounds interesting? How can i verify this? And what do you mean by
trashing the disk? swap is completely disabled.

I thought all memory which i can drop with drop_caches can be reclaimed?

Greets,
Stefan
