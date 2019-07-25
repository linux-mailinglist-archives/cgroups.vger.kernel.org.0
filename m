Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC774F2A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfGYNWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 09:22:44 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:35089 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfGYNWo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 09:22:44 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 09:22:43 EDT
Received: (qmail 24877 invoked from network); 25 Jul 2019 15:17:17 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.165]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 25 Jul 2019 15:17:17 +0200
To:     cgroups@vger.kernel.org
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: No memory reclaim while reaching MemoryHigh
Message-ID: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
Date:   Thu, 25 Jul 2019 15:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello all,

i hope i added the right list and people - if i missed someone i would
be happy to know.

While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
varnish service.

It happens that the varnish.service cgroup reaches it's MemoryHigh value
and stops working due to throttling.

But i don't understand is that the process itself only consumes 40% of
it's cgroup usage.

So the other 60% is dirty dentries and inode cache. If i issue an
echo 3 > /proc/sys/vm/drop_caches

the varnish cgroup memory usage drops to the 50% of the pure process.

I thought that the kernel would trigger automatic memory reclaim if a
cgroup reaches is memory high value to drop caches.

Isn't it? does it needs a special flag or tuning? Is this expected?

Before drop caches:
   Memory: 13.1G (high: 13.0G)

After drop caches:
   Memory: 5.8G (high: 13.0G)

Greets,
Stefan
