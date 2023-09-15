Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98CA7A179B
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjIOHlT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjIOHlP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 03:41:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664CA1;
        Fri, 15 Sep 2023 00:41:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB267C433C9;
        Fri, 15 Sep 2023 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694763669;
        bh=dVfu4w2NiWvgQSrc/fseHwlP/NzWq4M7GMOTKHDsJZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXYk3ApLn9hfsQ83Z/yA6JxgIS4oIbIBX57XuMRQSgST503VKG5H48dhCgKwIcbyR
         OK9J7rZgn6k47BvOuP6sTlgz2Ev5NIXDDt2xIT3tdRt9Sf/+A3ItmVyFs4Y3n5KRWc
         RB1nL5Hr9+90KR12bQJaTW2uw+9tjzNcHO+akP2BPrvzI/FAReCs9pbsxATiEHEnYu
         StTeTqQ7By5inCTKASjqvskqPfUL4X4ab1Ru90yUuajA5gmiERdJiMXi/MHler+Zts
         x9GS0+nYSSjg0n7UbZNR+ipQT4+5rOnSP8BaeZLWKwj4bpm7PylJg0p7v18IHTEtPP
         y4y7LwClq8iew==
Date:   Fri, 15 Sep 2023 09:40:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230915-nieren-bebauen-f5e2e23ac914@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
 <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
 <20230914165805.GJ800259@ZenIV>
 <20230914192331.GK800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914192331.GK800259@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 08:23:31PM +0100, Al Viro wrote:
> On Thu, Sep 14, 2023 at 05:58:05PM +0100, Al Viro wrote:
> 
> > Incidentally, I'm going to add a (belated by 10 years) chunk in porting.rst
> > re making sure that anything in superblock that might be needed by methods
> > called in RCU mode should *not* be freed without an RCU delay...  Should've
> > done that back in 3.12 merge window when RCU'd vfsmounts went in; as it
> > is, today we have several filesystems with exact same kind of breakage.
> > hfsplus and affs breakage had been there in 3.13 (missed those two), exfat
> > and ntfs3 - introduced later, by initial merges of filesystems in question.
> > Missed on review...
> > 
> > Hell knows - perhaps Documentation/filesystems/whack-a-mole might be a good
> > idea...

pitfalls.rst or common-bugs.rst

or something like that.

> 
> Actually, utf8 casefolding stuff also has the same problem, so ext4 and f2fs
> with casefolding are also affected ;-/


