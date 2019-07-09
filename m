Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CACF62DBE
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2019 03:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGIB4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Mon, 8 Jul 2019 21:56:02 -0400
Received: from app2.whu.edu.cn ([202.114.64.89]:39874 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfGIB4C (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 8 Jul 2019 21:56:02 -0400
Received: from MI20170214RZUL (unknown [111.202.192.3])
        by email2 (Coremail) with SMTP id AgBjCgBnNvQr9CNdzSxlAA--.254S3;
        Tue, 09 Jul 2019 09:55:56 +0800 (CST)
From:   "Peng Wang" <rocking@whu.edu.cn>
To:     "'Tejun Heo'" <tj@kernel.org>
Cc:     <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190708130132.5582-1-rocking@whu.edu.cn> <20190708144121.GA657710@devbig004.ftw2.facebook.com>
In-Reply-To: <20190708144121.GA657710@devbig004.ftw2.facebook.com>
Subject: RE: [PATCH] cgroup: simplify code for cgroup_subtree_control_write()
Date:   Tue, 9 Jul 2019 09:55:54 +0800
Message-ID: <000301d535f9$71f1ab90$55d502b0$@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE94/eHFYIYcEzptv5v1lkJv7sJaAH+JMagp+A37hA=
Content-Language: zh-cn
X-CM-TRANSID: AgBjCgBnNvQr9CNdzSxlAA--.254S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY87k0a2IF6r1xM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j
        6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F
        4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvE
        ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
        8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xS
        Y4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRN
        b10UUUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Monday, July 8, 2019 10:41 PM, Tejun Heo wrote:
> On Mon, Jul 08, 2019 at 09:01:32PM +0800, Peng Wang wrote:
> > Process "enable" and "disable" earlier to simplify code.
> 
> I don't think this is correct and even if it were the value of this
> change is close to none, so nack on this one.

OK. 
Although I have tested this patch for common case, It's just somewhat trivial.

Thanks for your time :-).

> 
> Thanks.
> 
> --
> tejun

