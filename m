Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6243B5B7B
	for <lists+cgroups@lfdr.de>; Mon, 28 Jun 2021 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhF1JnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Jun 2021 05:43:15 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF1JnP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Jun 2021 05:43:15 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7JnA-1lsHRM27Ku-007mlc; Mon, 28 Jun 2021 11:40:40 +0200
Subject: Re: Prevent inode/dentry trashing?
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Philipp Hahn <pmhahn+lkml@pmhahn.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
References: <ce330972-78e6-4347-9735-72ee7bb21ef5@pmhahn.de>
 <YNX8anv2yCnkVPXy@blackbook>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <88451906-e537-0ac3-b8f2-16bfc4d77ea6@metux.net>
Date:   Mon, 28 Jun 2021 11:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNX8anv2yCnkVPXy@blackbook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AnlrbnCYXCDKxsNInMzSy4z0MWZE2/tgb5xMbUWJev8+877cPZ3
 tOCwe2hauIMEs/xxcm8A/P9NHL6RGsF0YWxpa429h8uzVshKAcVN7OFTg0ffgIDtCMAvwIO
 KOR3rt6LGoYkqXO4umi6JQ26/YEh7RFR4u2bGj45wXQ66X/vOvnYe/KbWfpLLRkxOCf04Pz
 UgesK67YWPqUpP68jdrjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ayrA+qtP+Sg=:BdAMkVxlDXJ3xatdLNgt9T
 d+R+EA1TFuWOKQVOwvkKfm3lrFcbRuU+r4b3wQGpZtbopwDA+uDw5Mw4d7CgaLEOdFFfYhnEa
 aiNSCQF2wvkBzbuJUFOOieZOgLUzkT3m60n3eEdvnmr72N7QhUGomb68lBSk56VQ3/3fYLrQ3
 F1sI/mHNNCweoaPXIrWcvyloICt+kXGI+PkWyqUCTZJQp/HCC5694e06WWLIo8hzcU0zrx3bz
 Rspkix32PxXvVp56tX/mwjOHGdHDm+K38/3BoWIuaXgLqRnMgzKcpp8vzT1VqPa+XvOze14Wl
 mBn3/aWzG0LPnjX4zqzNDT6duGWn3Ues/otDSMYwjpze1UajebQCmReisXjD5Qz4WC9n80VkL
 2xEb+MrZx02BmltgS9V+Jizawp95b3dTydLqDsKENqJtFUmVeCkqJkkLqszswXad3557Z6ACL
 40c0uvrz5Bz/itnFK/fQ/eqIOj5F0q32qWxW9MOfDKnK4q0GDGD2NleJQdnNyasKo5MgzSheY
 EOfzMhvFmjtTKOs421yRG8=
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 25.06.21 17:55, Michal Koutný wrote:
>> Is it possible to prevent inode/dentry trashing for example by limiting the
>> cache per process(-group)?
> 
> Yes. Unless you have disabled it with CONFIG_MEMCG_KMEM or
> cgroup.memory=nokmem, dentries and inodes are charged to respective
> cgroups. And you can limit overall memory of a cgroup, see
> memory.{max,high} attributes. (You suggest this inode/dentry consumption
> is dominant enough to affect other jobs, so the limit would keep it
> constrained as you intend).

Could you please tell a bit more how this really works ?
(maybe some pointers to the code)

I'm curios what happens if those cache objects are used by different
cgroups - are they accounted to multiple times (once per cgroup) ?
What happens when one cgroup using some cache object reaching its limit,
wile another one does not ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
