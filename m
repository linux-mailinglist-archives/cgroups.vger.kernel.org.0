Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D17A2130
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjIOOkU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjIOOkT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 10:40:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9AC1AC;
        Fri, 15 Sep 2023 07:40:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6453C433C9;
        Fri, 15 Sep 2023 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694788814;
        bh=PvlOjbLkc3tgSHNCaVnS82ty1H0lvym1p0dyZTkOFDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsMXd6mZ8RM6Ehv3+oeXSFdJBK4XfA1s5jG3qJW397E3aH+o329rZ/VtgcJhEI2Ek
         GIJfdrxXDV/D+2h214W5hbDliVTBm3yN1eUgvtUVVZ1/ZgLJyELtBnprCB74Mvp2bO
         Y9yAjyDUJYhLQ2LABIiRFS7SjQAloadGL5GvZIH6h3ow+QooG9ilUBP37mYSe/gnfx
         Oe0um8v+i1YG5HcXkyDRJwPVS8rwGOnzAUkEZB8JlS5KwPI8HWoWokIviZ30JYSJLI
         VjWkPZQ6+IEwE3hlmnfM8EB719A4Al+/b90kwWaliUnxciX021zodiQcb+zRxyFzBc
         v2OPDzI9ovPwA==
Date:   Fri, 15 Sep 2023 16:40:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
Message-ID: <20230915-brust-gratis-156b7572a7c9@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915142814.GL800259@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Lifetime rules for fs-private parts of superblock are really private to

Fine, I'll drop that. It's still correct that a filesystem needs to take
care when it frees sb->s_fs_info. See the RCU fun you just encountered.


