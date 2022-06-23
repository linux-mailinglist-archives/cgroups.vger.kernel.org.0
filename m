Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02155731F
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiFWGaC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 02:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFWGaB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 02:30:01 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 23:29:58 PDT
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48B13A199
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 23:29:58 -0700 (PDT)
Received: by ajax-webmail-APP-13 (Coremail) ; Thu, 23 Jun 2022 14:24:25
 +0800 (GMT+08:00)
X-Originating-IP: [117.62.148.134]
Date:   Thu, 23 Jun 2022 14:24:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5a2Z5rui?= <sunying@nj.iscas.ac.cn>
To:     cgroups@vger.kernel.org
Subject: Will the "CONFIG_CGROUP_DEBUG"  x86_64 default configuration be
 turned off in later versions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3aa17045.1e364.1818f3bba02.Coremail.sunying@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowACnr9caB7RiXQIFAA--.27628W
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/1tbiCQsGAWKY1jwf6wACsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGksCkkgbm90aWNlZCB0aGF0IGFmdGVyIHY1LjE4LjAtcmMxIHRoZSBkZWZhdWx0IGNvbmZpZ3Vy
YXRpb24gb2YgIkNPTkZJR19DR1JPVVBfREVCVUciIGF0IHg4Nl82NCBhcmNoaXRlY3R1cmUgaXMg
dHVybmVkIG9uLCBpcyB0aGlzIGNvbmZpZ3VyYXRpb24ganVzdCB1c2VkIGZvciBjZ3JvdXBzIGRl
YnVnZ2luZywgd2lsbCBpdCBiZSB0dXJuZWQgb2ZmIGluIGxhdGVyIHZlcnNpb25zPwpUaGUgY29u
ZmlndXJhdGlvbiBpcyBzZXQgaW4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9sb2cvYXJjaC94ODYvY29uZmlncy94ODZfNjRf
ZGVmY29uZmlnIC4KClRoYW5rcyEKCgo=
