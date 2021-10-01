Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACC41EBFA
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhJALeq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 07:34:46 -0400
Received: from submit01.uniweb.no ([5.249.227.132]:37531 "EHLO
        submit01.uniweb.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJALep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 07:34:45 -0400
X-Greylist: delayed 1573 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Oct 2021 07:34:45 EDT
Received: from [10.20.0.27] (helo=mail.uniweb.no)
        by submit01.uniweb.no with esmtpa (Exim 4.93)
        (envelope-from <odin@digitalgarden.no>)
        id 1mWGNK-007IP2-TH; Fri, 01 Oct 2021 13:06:46 +0200
Date:   Fri, 1 Oct 2021 13:06:45 +0200
From:   Odin Hultgren van der Horst <odin@digitalgarden.no>
To:     cgroups@vger.kernel.org
Subject: [Question] io cgroup subsystem threaded support
Message-ID: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Posted to both cgroups and linux-block

Hi i read though some of the source code for cgroups, and from my understanding
the io cgroup subsystem does not support threaded cgroups. So i had some questions
regarding this.

 - Is there any future plans for supporting threaded?
 - What are the main hurdles in adding threaded support to the io cgroup subsystem?

Thanks,
Odin.
