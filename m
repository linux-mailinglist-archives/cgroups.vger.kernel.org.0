Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB4262470
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIIBWy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 8 Sep 2020 21:22:54 -0400
Received: from smtp.h3c.com ([60.191.123.50]:42705 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIIBWx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Sep 2020 21:22:53 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 0891MPH1090231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 09:22:25 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Sep 2020 09:22:26 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Wed, 9 Sep 2020 09:22:26 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Tejun Heo <tj@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blkcg: add plugging support for punt bio
Thread-Topic: [PATCH] blkcg: add plugging support for punt bio
Thread-Index: AQHWgqvNplY6FxgLP0eXXhL4lx8KdKlYUnqQgAGV3qCABKDKAIABAF5w
Date:   Wed, 9 Sep 2020 01:22:26 +0000
Message-ID: <a819f736609e44b6a75b7b877901b270@h3c.com>
References: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
 <8f84e1fe-9fa5-b7e7-1f2f-b0c4a40614e2@kernel.dk>
 <42b939c2.e08.173c6f79af9.Coremail.xianting_tian@126.com>
 <1ded6246.2c67.17458ce4300.Coremail.xianting_tian@126.com>
 <65e1e040da644ed9a05edd166d06b5e3@h3c.com>
 <20200908180302.GE4295@mtj.thefacebook.com>
In-Reply-To: <20200908180302.GE4295@mtj.thefacebook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0891MPH1090231
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks TJ and your previous guide to me.
I will summarize and resubmit the patch.

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Wednesday, September 09, 2020 2:03 AM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@kernel.dk; cgroups@vger.kernel.org; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: add plugging support for punt bio

On Sat, Sep 05, 2020 at 11:25:03AM +0000, Tianxianting wrote:
> Hi jens,tj
> Could you share a couple of  minutes to comment it?
> I really appreciate it

The result looks fine to me but can you please summarize that in the commit message of the patch?

Thanks.

--
tejun
