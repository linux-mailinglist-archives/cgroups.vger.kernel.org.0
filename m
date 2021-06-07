Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC70A39DCDD
	for <lists+cgroups@lfdr.de>; Mon,  7 Jun 2021 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFGMsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Jun 2021 08:48:13 -0400
Received: from birdy.pmhahn.de ([88.198.22.186]:43586 "EHLO birdy.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFGMsN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 7 Jun 2021 08:48:13 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 08:48:12 EDT
Received: from [IPv6:2003:e2:7701:c200:a5ae:ca72:d4d5:6724] (p200300e27701C200A5aeca72D4D56724.dip0.t-ipconnect.de [IPv6:2003:e2:7701:c200:a5ae:ca72:d4d5:6724])
        by birdy.pmhahn.de (Postfix) with ESMTPSA id DB9562207246;
        Mon,  7 Jun 2021 14:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=202002;
        t=1623069575; bh=BBOoFi9HzmEh7B1OpgYxyXy8hseIid57bVC7FAkBMWE=;
        h=To:From:Subject:Date:From;
        b=IldtndQH66LqgCtd1zYeQWCI5owbGkaqz8YMfWxhDaLSL9HvYI8OxYSPuII/RAia5
         YkTmp++EEFouXzNPMMlADn7E86uh3DgLlSl0rad9YToXrUPd0FbK2FrDlUwyfiJokr
         5lq+i/KM2mEZR9X9JGPISmN6UJvWOs99fJpZwS+Vym0Z+BdHtcRjFJQ5YGnNTplBL/
         R6KAbi+hpFei/a9uoV5GCYC7CfaKRoQ6zahgN+RvoZHEbMB6lkWk/TfSIfHL3XsVHl
         0O4xZBMRRZ3lw2xy/0Jp/GXYFb/idwZdV908N1b6kxpikUS/ZOQLRfukW1NrLnyk8y
         m7o9ODcFlrwyg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
From:   Philipp Hahn <pmhahn+lkml@pmhahn.de>
Subject: Prevent inode/dentry trashing?
Message-ID: <ce330972-78e6-4347-9735-72ee7bb21ef5@pmhahn.de>
Date:   Mon, 7 Jun 2021 14:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Similar to 
<https://unix.stackexchange.com/questions/202586/limit-the-inode-cache-used-by-a-command> 
I would like to prevent certain programs from trashing the inode/dentry 
cache, which is a shared resource for all processes:

- For example the nightly <man:updatedb(8)> used <man:find(1) > to 
recursively walk the complete file system. As long as `d_name` and the 
`d_type` information from <man:readdir(3)> is enough this only pollutes 
the dentry cache.

- Similar our backup software, but this also needs to <man:stat(2)> each 
path to get the `mtime`, which additionally pollutes the inode cache.

Both examples only walk the tree once (per day). In my case the caches 
do not fit into memory completely, so the second process does not even 
benefit from the first process filling the cache as that data is already 
replaced again.

The trashed caches affect all other processes running in parallel or the 
first processes started each morning.

Is it possible to prevent inode/dentry trashing for example by limiting 
the cache per process(-group)?
Something like MADV_DONTNEED from <man:madvise(2)> for IO would be nice.

An external knob to limit the cache usage per process(-group) would be 
nice, but even a hint for an API for such kind of programs to prevent 
trashing would help me.

Thank you in advance.
Philipp
