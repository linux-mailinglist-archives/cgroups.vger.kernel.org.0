Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFA7A2114
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjIOOeH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjIOOeG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 10:34:06 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111311AC;
        Fri, 15 Sep 2023 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tqcCFg+GZbSgwZKnqTUl8J8yKTkkr5or8a2TzqKdwfE=; b=fI03x0kfMwTyWxXp0q9RswfM3A
        kbA9MXFRf4J4DxmUwHoBdDY8tdCbQDKmmRR0wSeZ/O5QcnoQ/OO7EAWa2cT/b5N/VqRspAalCW9x7
        f+Wm67Sdn+ONcURBcbs7KKK7upRaV+2FlkVVuyK/sRhy7ddvUV56FEvtMaGUnI/F8F2p7b/+noDyT
        jczSmUTmHrCWdQANori9mXgiTJ3Mg54g4LDIXCW6OrIGlzNfwGvn+gKJvLG5vvGji8SvjvZzxf5eX
        mrJlm/8G9rWZmQ+0cv4Lj91/6YyMGTkxIfW5GAGSzneczvuVPPWV8ffiFIKmlaN4R5ROY1siEVCv0
        xE6+/x8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qh9t9-006Kf9-2j;
        Fri, 15 Sep 2023 14:33:43 +0000
Date:   Fri, 15 Sep 2023 15:33:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
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
        cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230915143343.GM800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
 <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
 <20230914165805.GJ800259@ZenIV>
 <20230915-elstern-etatplanung-906c6780af19@brauner>
 <20230915-zweit-frech-0e06394208a3@brauner>
 <20230915142814.GL800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915142814.GL800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 15, 2023 at 03:28:14PM +0100, Al Viro wrote:
> On Fri, Sep 15, 2023 at 04:12:07PM +0200, Christian Brauner wrote:
> > +	static void some_fs_kill_sb(struct super_block *sb)
> > +	{
> > +		struct some_fs_info *info = sb->s_fs_info;
> > +
> > +		kill_*_super(sb);
> > +		kfree(info);
> > +	}
> > +
> > +It's best practice to never deviate from this pattern.
> 
> The last part is flat-out incorrect.  If e.g. fatfs or cifs ever switches
> to that pattern, you'll get UAF - they need freeing of ->s_fs_info
> of anything that ever had been mounted done with RCU delay; moreover,
> unload_nls() in fatfs needs to be behind the same.
> 
> Lifetime rules for fs-private parts of superblock are really private to
> filesystem; their use by sget/sget_fc callbacks might impose restrictions
> on those, but that again is none of the VFS business.

PS: and no, we don't want to impose such RCU delay on every filesystem
out there; what's more, there's nothing to prohibit e.g. having ->s_fs_info
pointing to a refcounted fs-private object (possibly shared by various
superblocks), so freeing might very well be "drop the reference and destroy
if refcount has reached 0".
