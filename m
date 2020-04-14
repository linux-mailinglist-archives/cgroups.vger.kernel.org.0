Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433F81A8A51
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgDNS4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:56:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:52369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504506AbgDNS4Z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Apr 2020 14:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586890578;
        bh=+Tdr2K02RJI+GpvSdoZWt162/aAc9VhDfCwMAjh/zRQ=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=To6+SlucjMC+NnMnolrmspIqPDfcmfdtkJM0Od0mT1wnzsV70RQI4qgrnC5rkCZa0
         P1XDBbxOg4KLmKxxhhrO9Y2G5Jou6NG0l5nGkTLO9XFcx8is0qCBzBt/6+MiCeUmoF
         WwaDO0DTnczL3MEP38bv/mkPH4IEb+u1hat9egfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.23.198] ([46.81.210.70]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1jAeuK3jHx-015WjF for
 <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 20:56:17 +0200
To:     cgroups@vger.kernel.org
From:   Timo Haas <haastimo@gmx.de>
Subject: Documentation cgroups v1
Message-ID: <b8577be4-18d5-4e81-8f59-6b4ad68e9f10@gmx.de>
Date:   Tue, 14 Apr 2020 20:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tczht2gLEQR2OEj4CJY2QpIVSrFmGDh5BJLtxAlHpMtItY7lSd5
 1l/ovhryEvEvHrVAs6cz+y4Kx9GRnSPXCfKqJ98MqV2tETn5x3mVfWErFBB4QkM9Ex66kLl
 o3jbiwBb7jyx5fkzagtYfn4emBdf4b3PsIWTLlwsN2PAjXvXwmM07418g8kwHyjcrJ+9VwF
 R1jIa1WA2m9JcUKQWiZ1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/fomsaq2rY=:xB+2bQtMUnDRsRHsNgph4v
 k3qPwNJfbt1stXMeIEqjUILpkSxFQDdnwlvtBEZjuYBksMm1cxgV4LsJlQgBfJI5AdBbUGllG
 A8T829uu1wN5UjmAp1XKqD0saSfRB2zizt3rNFcBmDT6qrZV8bYyQ6PFTXRFgkImfYJfZv/Uv
 Tw8i835vSOdf4S0lZCU6SnfFFBFdjXcMDLTq9qCUL4MHqta7KrMWPN6VGDhb5KsH/3PWolENs
 60lH96fgsS/up/lELgFF7zuMsmTX2YL1HgMjNRkOe7Ob7ZS0YU+SeF3sWiz57rau7+ElpWKLo
 J9MTQAAsAxNuDYLD2fBRhW794gP4Illbun1tMIa1QKwG2kRWXFCCVQHUWfgi7GTxhqbjEqGUO
 M8vJfxnwK1pzeurOT4S0yrSLBF9mV5rVNGrdJ5gvFcsIJVaQo6idJDohHu2CIKxJaos31KnWf
 7KMFtOcU61iKyG6oZURsxJcII6I6v2IMBf2ojI44RetVZyVrQ7ZVSeLOe6SYKKkyS0WxlqSfW
 nYcKr1aHxRZQPArD1WAyjyovaxB+XpcVjM1b2CiobXGZeoVdxzVurYHVxzFKyXbGhlaXgvIjr
 gk+kRYtOdQXbFUE0M+3mCBqee/cgpQaVbAYN34KbQiFw6k6VQkMciQja68xyG33hEk12yJHGC
 wRdv4jJh4jp5DEFT+fRfKDWttq4Bdn8NTcTadRSH15rlaO1uRlUOUklrM1yOFeQhUd3gExLpK
 f+E/eK4WNYTtx1yro5KCG3UFSKmgrASNOXuMTV5VCcoVFykBkFLhsLgQ7ENUkmGkEqS6/q29n
 nyIrZXteuP4n2QIRrxV2iC9KmFtEScI4IGbCF8TeYD62Rh1Uw2mDqq2xwizDrTiRYPwXTrWpr
 MBIUs8nZkVrU6MwWuDhM1eoKbrpoBfRScUxSvTgxJglsHBcxSgwAuu3744S5d5FwzB3BqCqvg
 ZW62MH4SbESSf0AevdnTvTCldIFEZUTZ+cQo8RJkkljEg7RjP+H4Zf7O+GGBRtMvQC6h3bNqm
 qVT85VfYddc+EajXKVaesoB6gsr2Gzxh6BHCYy3S7Sp+v36Njzk3tdOb92jzlEjzQ/4fOsnVb
 7iSANzsxzOekzQHRDpOVVEaG0WR0ehHI3Q3cRkcJX9m30I3ycXnFS4wYT00rS0zkfF8yyYjcR
 njSqNCHBED/QwE1qSitbSS38SyFA/XIhiap8MlwbotVE9NT7vg+qL5ebyo2SPk0+DPZ3loQE/
 NHB05TfUtsDN3QOj7
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

I've got a question: The cgroups-v1 documentation doesn't mention
anymore the status of recording blkio.io_serviced and
blkio.io_service_bytes stats when files are written without the O_DIRECT
flag within a subgroup. With cgroups v2 it can be accurately recorded if
the filesystem supports it. What is the status in cgroups v1?

I assume it has not changed and it can't keep the stats because there is
no communication with the memory controller. Or have the improvements
made in cgroups v2 ported to cgroups v1?

Background: [1] added documentation on limitations of blkio stats
collection in cgroups v1.
[2] refactored the documentation and I think mistakenly deleted too much.

Thanks
	Timo Haas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/cgroups/blkio-controller.txt?h=v4.14-rc4&id=3e1534cf4a2a8278e811e7c84a79da1a02347b8b
[2]
https://git.kernel.org/pub//scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c2920926b10e8303378408e3c2b8952071d4344
