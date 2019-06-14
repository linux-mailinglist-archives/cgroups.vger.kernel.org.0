Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F0465C6
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNRcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 13:32:25 -0400
Received: from mengyan1223.wang ([89.208.246.23]:53280 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNRcZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 14 Jun 2019 13:32:25 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 13:32:25 EDT
Received: from [IPv6:2408:8270:a51:2470:fdc9:19d4:d061:dd4f] (unknown [IPv6:2408:8270:a51:2470:fdc9:19d4:d061:dd4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id E5992661A7;
        Fri, 14 Jun 2019 13:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1560533240;
        bh=yTeIDR8OPujbk6MctDZM6IAxXTb8pJmGs1d1cV7uKXU=;
        h=Subject:From:To:Cc:Date:From;
        b=dZ+GcXpzFucVC/JKckLnvd/5nUqIins0QSxzytqHdyCYzoMYFJZR7CIbZLThO0mGF
         V8xeZAyDlGb/D8lycY0N/YgNs7bt/wZLZDV9gt0xQXo+cqcZ+nRBRAIetXopsSjUew
         6xN4bfqvt/wFTl5RAoisOg7Cxf1ofS2gUksChoDn6OsZ/p31DCH9BmdcYnF3wVP8DW
         2UBDkliLcnltwNnJN1fP2UbUjFLvVm1ENSZaw6rVO1bZcH2hdodjakHmDmUXyAmowD
         iwmy9aF6AGdeWa7YizflmrntcrXrY2jotO9Jq9ij25fun7EfJQyMuEyZU6SxxDILeh
         SpxWOMHIiSmTg==
Message-ID: <5212f7c5df181d8a0d7a1d3c4b74da269c85a918.camel@mengyan1223.wang>
Subject: Is it possible to implement max_usage_in_bytes for cgroup v2?
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     xry111@mengyan1223.wang
Date:   Sat, 15 Jun 2019 01:27:10 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I'm currently working on a test automation system.  I plan to use memory cgroup
to limit and account the memory usage of the package being tested.

In cgroup v1 we can read memory.max_usage_in_bytes to get a the maximum value of
memory usage during testing.  But this feature (or "misfeature"?) is lacking in
cgroup v2 which I want to use (since cgroup v1 is deprecated).

Now is it possible to implement something like max_usage_in_bytes for cgroup v2?
If it's impossible I'll just sample memory.current for each 0.1s :(.

(Please keep me in To: or Cc: in reply since I'm not a subscriber.)
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

