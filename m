Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A652142F0
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGDDVT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGDDVR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:21:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB8C061794;
        Fri,  3 Jul 2020 20:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IYOmOJoYZTBzZj9tcefKQPSQ7bdbtk5gsplfzDl4zv8=; b=RDI/Bdk8o1Faay9KdZmlzUO+AA
        m9o/n0YxzrBme19YPdPlCs6aSDNnHgXacy3SY0Tdmr/4smmEjBkkP5fSiwBPjm6W0rmT9dI6DUqB+
        WPHy1NRhErLBOSZm3A3Bf+bwJ9OBXlfP3tT2RRuxrlR99dEPK7dPaWT9lxLrl3ZwSnGGAYcw2jHgB
        W/3HGLyYFeyYxOR1/ANiuRukON94z6AHvMn1jLVlTIl8DaCF/sPqUhvS3zbj5LrIh8RFBBpgRJ1Z3
        d7bJ4CWw+xjil4LqVozb2pkxgw+V7EI4L00GtUN7dBTuSRaE0MQRcpfhjuK0LA6Q1dhrNNiAsIssx
        Y0YtEhcw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjq-0000Ri-9h; Sat, 04 Jul 2020 03:21:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        cgroups@vger.kernel.org, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 10/13] Documentation/admin-guide: intel-speed-select: drop doubled words
Date:   Fri,  3 Jul 2020 20:20:17 -0700
Message-Id: <20200704032020.21923-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled words "that" and "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 Documentation/admin-guide/pm/intel-speed-select.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/admin-guide/pm/intel-speed-select.rst
+++ linux-next-20200701/Documentation/admin-guide/pm/intel-speed-select.rst
@@ -114,7 +114,7 @@ base performance profile (which is perfo
 Lock/Unlock status
 ~~~~~~~~~~~~~~~~~~
 
-Even if there are multiple performance profiles, it is possible that that they
+Even if there are multiple performance profiles, it is possible that they
 are locked. If they are locked, users cannot issue a command to change the
 performance state. It is possible that there is a BIOS setup to unlock or check
 with your system vendor.
@@ -883,7 +883,7 @@ To enable Intel(R) SST-TF, execute::
         enable:success
 
 In this case, the option "-a" is optional. If set, it enables Intel(R) SST-TF
-feature and also sets the CPUs to high and and low priority using Intel Speed
+feature and also sets the CPUs to high and low priority using Intel Speed
 Select Technology Core Power (Intel(R) SST-CP) features. The CPU numbers passed
 with "-c" arguments are marked as high priority, including its siblings.
 
