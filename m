Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599E4AA185
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfIELci (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 07:32:38 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:61383 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388551AbfIELci (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 07:32:38 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 07:32:37 EDT
Received: (qmail 11436 invoked from network); 5 Sep 2019 13:27:11 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.4]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 05 Sep 2019 13:27:11 +0200
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     l.roehrs@profihost.ag, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: lot of MemAvailable but falling cache and raising PSI
Message-ID: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
Date:   Thu, 5 Sep 2019 13:27:10 +0200
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

i hope you can help me again to understand the current MemAvailable
value in the linux kernel. I'm running a 4.19.52 kernel + psi patches in
this case.

I'm seeing the following behaviour i don't understand and ask for help.

While MemAvailable shows 5G the kernel starts to drop cache from 4G down
to 1G while the apache spawns some PHP processes. After that the PSI
mem.some value rises and the kernel tries to reclaim memory but
MemAvailable stays at 5G.

Any ideas?

Thanks!

Greets,
Stefan

