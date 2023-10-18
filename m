Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4146D7CD786
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJRJHl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 05:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRJHl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 05:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26AF9;
        Wed, 18 Oct 2023 02:07:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8165EC433C8;
        Wed, 18 Oct 2023 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697620055;
        bh=l4Oi5jf7qwP7CNkVZZNY8DYKTprQka+ShuoW7/Do0XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es+vckhML6CwqSwgV65RXAlRZMWLbJFu15MMUKk8v2FW7P8yVmNtSfevXtU6CZVpi
         1aXIT0xlmZQxoHDSB41Hd0M6Yl5gvFB9ndB/3MMRYkyK0SVbwmycZILJ34ScJgsEI1
         MZkiuI/7TrNP63l93BvLPwohbV30RvwSgY0KJADjWYGGcJ4x2qNuqCiAWWW1CQej3z
         +CgXIt6LkEbIqhSbQyziW92oHc+fMua0o8X8/UXdgEeNT6MJ66KP0XhIvN7LfbQTlu
         zwj2I0fNQaXGsNv7zZnI7XS/xDrYK4X5emfstphKe1WOs4AyPbL86nShPFJAslBb0b
         kaYvjnNnjiEUA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org,
        joseph.qi@linux.alibaba.com, tj@kernel.org, jack@suse.cz,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3] writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs
Date:   Wed, 18 Oct 2023 11:07:20 +0200
Message-Id: <20231018-dinkelbrot-botanik-b119bb8f4989@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014125511.102978-1-jefflexu@linux.alibaba.com>
References: <20231014125511.102978-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=l4Oi5jf7qwP7CNkVZZNY8DYKTprQka+ShuoW7/Do0XQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTqL9D597YqabVumacg890tWi7FOTdf1KYeag5488dwi5LI iveXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSm8vI0GzdrhQdq1mSnma6TOJwtz XT0uMtbxSiu66+2fQ6IyFgKiPDR7GfSf1cU1mbQo5t+FomoMy+3rL19dQL72xfbnh0TDCOCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 14 Oct 2023 20:55:11 +0800, Jingbo Xu wrote:
> The cgwb cleanup routine will try to release the dying cgwb by switching
> the attached inodes.  It fetches the attached inodes from wb->b_attached
> list, omitting the fact that inodes only with dirty timestamps reside in
> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
> with dirty timestamps can not be switched to a live cgwb for a long time.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs
      https://git.kernel.org/vfs/vfs/c/27890db5162c
