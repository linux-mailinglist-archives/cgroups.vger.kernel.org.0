Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2EE9969
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJ3JsJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 30 Oct 2019 05:48:09 -0400
Received: from mx21.baidu.com ([220.181.3.85]:34597 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfJ3JsI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Oct 2019 05:48:08 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 05:48:07 EDT
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id 38CB867CA021E;
        Wed, 30 Oct 2019 17:32:40 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 30 Oct 2019 17:32:41 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Wed, 30 Oct 2019 17:32:41 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: mount cgroup with "already mounted or cgroup busy"
Thread-Topic: mount cgroup with "already mounted or cgroup busy"
Thread-Index: AdWPA9906A1LJjv0Rpi5m0VcmmdBIA==
Date:   Wed, 30 Oct 2019 09:32:41 +0000
Message-ID: <11be9352e1e54ebebad078b1dac7b670@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi:

I meet a issue, and not sure if it is normal
Using the below script, the last line mount will fail after unmount
And it will fail until reboot system

mount -t cgroup -o cpu,cpuset xx cgroup
mkdir cgroup/x
rmdir cgroup/x
umount cgroup
mount -t cgroup -o cpu xx cgroup
mount: xx already mounted or cgroup busy

but if I add sleep, it will success

mount -t cgroup -o cpu,cpuset xx cgroup
mkdir cgroup/x
rmdir cgroup/x
sleep 10  <<<<==========
umount cgroup
mount -t cgroup -o cpu xx cgroup

- Li RongQing


