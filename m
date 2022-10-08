Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8145F84CA
	for <lists+cgroups@lfdr.de>; Sat,  8 Oct 2022 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJHKiM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 Oct 2022 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKiK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 8 Oct 2022 06:38:10 -0400
Received: from out0-142.mail.aliyun.com (out0-142.mail.aliyun.com [140.205.0.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0A140CA
        for <cgroups@vger.kernel.org>; Sat,  8 Oct 2022 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1665225486; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        bh=BF7Eln37ld2TT6I84mTZbuNy98vGKNxm0zeeSqjvgl0=;
        b=tclyiYMMsNlSR6wdRcsgM35/7jeM+B4qMokeqnjEex2UHXkV6TX54uduPtmyYYxSoPrPRqWSRReuZ1aTgZjSLSvXgEL1ZV1BFj+wPrr4DFOqJoe+vln+k+1n30NH2pSiccLxsnx8vpcujPu127fT8SKhjABRGHXDWA4nSwKOhYw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=huan.wanghuan@alibaba-inc.com;NM=1;PH=DW;RN=2;SR=0;TI=W4_0.1.38_v5ForWebDing_212D4846_1665222908698_o7001c31c;
Received: from WS-web (huan.wanghuan@alibaba-inc.com[W4_0.1.38_v5ForWebDing_212D4846_1665222908698_o7001c31c]) at Sat, 08 Oct 2022 18:38:05 +0800
Date:   Sat, 08 Oct 2022 18:38:05 +0800
From:   "=?UTF-8?B?546L5qyiKOS6keeXlSk=?=" <huan.wanghuan@alibaba-inc.com>
To:     "cgroups" <cgroups@vger.kernel.org>
Cc:     "linux-mm" <linux-mm@kvack.org>
Reply-To: "=?UTF-8?B?546L5qyiKOS6keeXlSk=?=" <huan.wanghuan@alibaba-inc.com>
Message-ID: <e9c98d52-9291-48b8-8a11-b44abfcee62c.huan.wanghuan@alibaba-inc.com>
Subject: =?UTF-8?B?Q2FuIGNncm91cCBtZW1vcnkgc3Vic3lzdGVtIHByb3ZpZGUgZXN0aW1hdGVkIGF2YWlsYWJs?=
  =?UTF-8?B?ZSBtZW1vcnksIGp1c3QgbGlrZSAvcHJvYy9tZW1pbmZvOiBNZW1BdmFpbGFibGU/?=
X-Mailer: [Alimail-Mailagent revision 38395113][W4_0.1.38][v5ForWebDing][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_0.1.38_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNS4wLjAuMCBTYWZhcmkvNTM3LjM2La
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGVsbG8gZXhwZXJ0cywKCi9wcm9jL21lbWluZm86IE1lbUF2YWlsYWJsZSBpcyBhIHZlcnkgdXNl
ZnVsIG1lcnRpY3MgdGhhdCBwcm92aWRlcyBlc3RpbWF0ZWQgYXZhaWxhYmxlIG1lbW9yeS4gSXQg
aXMgaW1wbGVtZW50ZWQgYnkgdGhlIHNpX21lbV9hdmFpbGFibGUoKSBmdW5jdGlvblsxXSBhbmQg
Y2FsY3VsYXRlZCBieSBNZW1GcmVlLCBBY3RpdmUoZmlsZSksIEluYWN0aXZlKGZpbGUpLCBTUmVj
bGFpbWFibGUgYW5kIFdhdGVybWFya3MuICBDYW4gY2dyb3VwIG1lbW9yeSBzdWJzeXN0ZW0gcHJv
dmlkZSBlc3RpbWF0ZWQgYXZhaWxhYmxlIG1lbW9yeT8KCi9wcm9jL21lbWluZm86Ck1lbVRvdGFs
OiAgICAgICA2Mzc5Mzg4OCBrQgpNZW1GcmVlOiAgICAgICAgMjExMjQ3MDQga0IKTWVtQXZhaWxh
YmxlOiAgIDM5MTA2MDg4IGtCCgotLS0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTM0ZTQzMWIw
YWUzOThmYzU0ZWE2OWZmODVlYzcwMDcyMmM5ZGE3NzMKCgoKCgoK
