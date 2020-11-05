Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4B2A75D9
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbgKEDBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 22:01:43 -0500
Received: from m1331.mail.163.com ([220.181.13.31]:24429 "EHLO
        m1331.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgKEDBn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 22:01:43 -0500
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 22:01:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=MbJ4j
        SQ9NcxDw1MYdK9VeZXzTkW8dChBtbcdzOJbkoo=; b=B/lY2RsBObmpA0rifnVkS
        F4At5Hxb74vF421+tb0guw7QBMQ25I/2lL8V6+3ZAN6cdfBui/jKlxcXrttlP//x
        n+YgK1VUq9bNqMqu4giMY3wHaTXR1b+P4jVtXsXh1wDtHUvKBGPpZ8EDoz909Icn
        3H5OX4GiVq70Vr80NDNkdE=
Received: from sh_def$163.com ( [14.18.249.244] ) by ajax-webmail-wmsvr31
 (Coremail) ; Thu, 5 Nov 2020 10:45:20 +0800 (CST)
X-Originating-IP: [14.18.249.244]
Date:   Thu, 5 Nov 2020 10:45:20 +0800 (CST)
From:   =?GBK?B?y9W71A==?= <sh_def@163.com>
To:     "Roman Gushchin" <guro@fb.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] mm/memcontrol: replace '== root_mem_cgroup' with
 mem_cgroup_is_root
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <20201104224622.GE1938922@carbon.dhcp.thefacebook.com>
References: <20201104151457.GA108301@rlk>
 <20201104224622.GE1938922@carbon.dhcp.thefacebook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4c956479.1572.175964b555a.Coremail.sh_def@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: H8GowADn79dAZ6NfaUhuAA--.32521W
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByxrTX1PAPj0N2gABsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CkF0IDIwMjAtMTEtMDUgMDY6NDY6MjIsICJSb21hbiBHdXNoY2hpbiIgPGd1cm9AZmIuY29tPiB3
cm90ZToKPk9uIFdlZCwgTm92IDA0LCAyMDIwIGF0IDExOjE0OjU3UE0gKzA4MDAsIEh1aSBTdSB3
cm90ZToKPj4gV2UgaGF2ZSBzdXBwbGllZCB0aGUgaW5saW5lIGZ1bmM6IG1lbV9jZ3JvdXBfaXNf
cm9vdCgpLgo+PiBTbyB3ZSBtYXkgdXNlIG1lbV9jZ3JvdXBfaXNfcm9vdCgpIGluc3RlYWQgb2Yg
dXNpbmcKPj4gJ21lbWNnID09IHJvb3RfbWVtX2Nncm91cCcgb3IgJ21lbWNnICE9IHJvb3RfbWVt
X2Nncm91cCcKPj4gZGlyZWN0bHksIHdoaWNoIGlzIG1vcmUgcmVhZGFibGUuCj4KPk1vc3Qgb2Yg
dGhlc2UgY29tcGFyaXNvbnMgd2lsbCBnbyBhd2F5IHNvb246Cj5odHRwczovL2xrbWwub3JnL2xr
bWwvMjAyMC8xMC8yMS82MTIgKHRoaXMgaXMKPmFuIHJmYyB2ZXJzaW9uLCBJJ2xsIHNlbmQgYW4g
dXBkYXRlZCB2ZXJzaW9uIHNvb24pLgo+Cj5UaGFua3MhCgpZZWFoLCB0aGFua3MuCgpQbGVhc2Ug
aWdub3JlIHRoaXMgY2hhbmdlLgo=
