Return-Path: <cgroups+bounces-15084-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCMELX0Yx2mXSwUAu9opvQ
	(envelope-from <cgroups+bounces-15084-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 00:53:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C234C903
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03D93025937
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E032A3EC;
	Fri, 27 Mar 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeYG0F04"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D022877F7;
	Fri, 27 Mar 2026 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655467; cv=none; b=NK+lLH1+tTv7E2cZCc3jldzyNjQrC4lVOUcDJx88HBTc5rT8sXtm+jGbF7lyvySy4h0ll0/5jQzzpirgwfsdo5KSlsPhj0BhryydH2Mf5OieKB4SaXv30oNd0IKoX7lQTVUK0uyI280CmQe6zRZkWGuhx0nkzuFAY6WNMjiwuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655467; c=relaxed/simple;
	bh=NB4q5F2SF22dSk2xnw9zNIIRimCK64imyAh0EWDk5DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep+unzsXA01pfVs0WVlnSjm52d9A3jhKTRH1yIyZjbUVMGy2GiKu/HRg2vPJ7fnIP0i7dbwy0HqHl0QFEEYDb/uVPNTpDzwjoPgxtdNELRFz9+mFcAPJPYWr9ERvSEdNtcoaIFecw5j/NZhN1FOXCZT2FqDb+ABxZj/4sQVrhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeYG0F04; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774655464; x=1806191464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NB4q5F2SF22dSk2xnw9zNIIRimCK64imyAh0EWDk5DA=;
  b=MeYG0F041o4R3ElhiQmYTHRQz9uhN+0RriKEZhgFiWI6g5T7kWJ/mNed
   N45aJUUwpS7EgniO/KW6d54ML6lpRfgO0vZNzXcbPcozrOpApxHXCEIDB
   ssuGh8T9PtzVxjvCRjbIZld51OGLvpINs/vKV4hCGppIyEytle0WxND6S
   QMfa+xaJbSjd8X7yOdaRknDsn6oX63h57m+1kEgBA1KKDNixhGBUK/iCo
   ZHiheYEc6pPsdhFiSUsWX0fd9byoLa/Wl+3gJpj90yn9VmesZizUYMMag
   NpoIHpIHHyjKfnHiliAYfESdyJIiEfrQDRPZr9IN9FLgOb28ZZ9nSCpaR
   w==;
X-CSE-ConnectionGUID: STrwIKh4T26h9VhJvhjq6Q==
X-CSE-MsgGUID: BSzNAZPXTf+wV5kVCTx2jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86426364"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="86426364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:51:03 -0700
X-CSE-ConnectionGUID: jaNo6+CZQD6tkhFOLRi7vg==
X-CSE-MsgGUID: DWMpbL8rRxK7ojvbAQEJCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="224491953"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 27 Mar 2026 16:50:59 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Gx5-000000007a9-3uLA;
	Fri, 27 Mar 2026 23:50:55 +0000
Date: Sat, 28 Mar 2026 00:50:44 +0100
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com
Subject: Re: [PATCH v5 3/4] mm: memcontrol: add interfaces for swap tier
 selection
Message-ID: <202603280046.d4u6S8W9-lkp@intel.com>
References: <20260325175453.2523280-4-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325175453.2523280-4-youngjun.park@lge.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kvack.org,kernel.org,lge.com,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15084-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 113C234C903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6381a729fa7dda43574d93ab9c61cec516dd885b]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20260327-203639
base:   6381a729fa7dda43574d93ab9c61cec516dd885b
patch link:    https://lore.kernel.org/r/20260325175453.2523280-4-youngjun.park%40lge.com
patch subject: [PATCH v5 3/4] mm: memcontrol: add interfaces for swap tier selection
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260328/202603280046.d4u6S8W9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603280046.d4u6S8W9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,\b(\S*)(Documentation/[A-Za-z0-9
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/devicetree/dt-object-internal.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,^Documentation/scheduler/sched-pelt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,(Documentation/translations/[
   Using alabaster theme
>> Documentation/admin-guide/cgroup-v2.rst:1860: WARNING: Inline substitution_reference start-string without end-string. [docutils]
>> Documentation/admin-guide/cgroup-v2.rst:1860: WARNING: Inline substitution_reference start-string without end-string. [docutils]
   Documentation/core-api/kref:328: ./include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
   int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
   ------------------------------------------------------------------------------------------------^
   Documentation/core-api/kref:328: ./include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
   int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)


vim +1860 Documentation/admin-guide/cgroup-v2.rst

  1427	
  1428		  ==========            ================================
  1429		  swappiness            Swappiness value to reclaim with
  1430		  ==========            ================================
  1431	
  1432		Specifying a swappiness value instructs the kernel to perform
  1433		the reclaim with that swappiness value. Note that this has the
  1434		same semantics as vm.swappiness applied to memcg reclaim with
  1435		all the existing limitations and potential future extensions.
  1436	
  1437		The valid range for swappiness is [0-200, max], setting
  1438		swappiness=max exclusively reclaims anonymous memory.
  1439	
  1440	  memory.peak
  1441		A read-write single value file which exists on non-root cgroups.
  1442	
  1443		The max memory usage recorded for the cgroup and its descendants since
  1444		either the creation of the cgroup or the most recent reset for that FD.
  1445	
  1446		A write of any non-empty string to this file resets it to the
  1447		current memory usage for subsequent reads through the same
  1448		file descriptor.
  1449	
  1450	  memory.oom.group
  1451		A read-write single value file which exists on non-root
  1452		cgroups.  The default value is "0".
  1453	
  1454		Determines whether the cgroup should be treated as
  1455		an indivisible workload by the OOM killer. If set,
  1456		all tasks belonging to the cgroup or to its descendants
  1457		(if the memory cgroup is not a leaf cgroup) are killed
  1458		together or not at all. This can be used to avoid
  1459		partial kills to guarantee workload integrity.
  1460	
  1461		Tasks with the OOM protection (oom_score_adj set to -1000)
  1462		are treated as an exception and are never killed.
  1463	
  1464		If the OOM killer is invoked in a cgroup, it's not going
  1465		to kill any tasks outside of this cgroup, regardless
  1466		memory.oom.group values of ancestor cgroups.
  1467	
  1468	  memory.events
  1469		A read-only flat-keyed file which exists on non-root cgroups.
  1470		The following entries are defined.  Unless specified
  1471		otherwise, a value change in this file generates a file
  1472		modified event.
  1473	
  1474		Note that all fields in this file are hierarchical and the
  1475		file modified event can be generated due to an event down the
  1476		hierarchy. For the local events at the cgroup level see
  1477		memory.events.local.
  1478	
  1479		  low
  1480			The number of times the cgroup is reclaimed due to
  1481			high memory pressure even though its usage is under
  1482			the low boundary.  This usually indicates that the low
  1483			boundary is over-committed.
  1484	
  1485		  high
  1486			The number of times processes of the cgroup are
  1487			throttled and routed to perform direct memory reclaim
  1488			because the high memory boundary was exceeded.  For a
  1489			cgroup whose memory usage is capped by the high limit
  1490			rather than global memory pressure, this event's
  1491			occurrences are expected.
  1492	
  1493		  max
  1494			The number of times the cgroup's memory usage was
  1495			about to go over the max boundary.  If direct reclaim
  1496			fails to bring it down, the cgroup goes to OOM state.
  1497	
  1498		  oom
  1499			The number of time the cgroup's memory usage was
  1500			reached the limit and allocation was about to fail.
  1501	
  1502			This event is not raised if the OOM killer is not
  1503			considered as an option, e.g. for failed high-order
  1504			allocations or if caller asked to not retry attempts.
  1505	
  1506		  oom_kill
  1507			The number of processes belonging to this cgroup
  1508			killed by any kind of OOM killer.
  1509	
  1510	          oom_group_kill
  1511	                The number of times a group OOM has occurred.
  1512	
  1513	          sock_throttled
  1514	                The number of times network sockets associated with
  1515	                this cgroup are throttled.
  1516	
  1517	  memory.events.local
  1518		Similar to memory.events but the fields in the file are local
  1519		to the cgroup i.e. not hierarchical. The file modified event
  1520		generated on this file reflects only the local events.
  1521	
  1522	  memory.stat
  1523		A read-only flat-keyed file which exists on non-root cgroups.
  1524	
  1525		This breaks down the cgroup's memory footprint into different
  1526		types of memory, type-specific details, and other information
  1527		on the state and past events of the memory management system.
  1528	
  1529		All memory amounts are in bytes.
  1530	
  1531		The entries are ordered to be human readable, and new entries
  1532		can show up in the middle. Don't rely on items remaining in a
  1533		fixed position; use the keys to look up specific values!
  1534	
  1535		If the entry has no per-node counter (or not show in the
  1536		memory.numa_stat). We use 'npn' (non-per-node) as the tag
  1537		to indicate that it will not show in the memory.numa_stat.
  1538	
  1539		  anon
  1540			Amount of memory used in anonymous mappings such as
  1541			brk(), sbrk(), and mmap(MAP_ANONYMOUS). Note that
  1542			some kernel configurations might account complete larger
  1543			allocations (e.g., THP) if only some, but not all the
  1544			memory of such an allocation is mapped anymore.
  1545	
  1546		  file
  1547			Amount of memory used to cache filesystem data,
  1548			including tmpfs and shared memory.
  1549	
  1550		  kernel (npn)
  1551			Amount of total kernel memory, including
  1552			(kernel_stack, pagetables, percpu, vmalloc, slab) in
  1553			addition to other kernel memory use cases.
  1554	
  1555		  kernel_stack
  1556			Amount of memory allocated to kernel stacks.
  1557	
  1558		  pagetables
  1559	                Amount of memory allocated for page tables.
  1560	
  1561		  sec_pagetables
  1562			Amount of memory allocated for secondary page tables,
  1563			this currently includes KVM mmu allocations on x86
  1564			and arm64 and IOMMU page tables.
  1565	
  1566		  percpu (npn)
  1567			Amount of memory used for storing per-cpu kernel
  1568			data structures.
  1569	
  1570		  sock (npn)
  1571			Amount of memory used in network transmission buffers
  1572	
  1573		  vmalloc (npn)
  1574			Amount of memory used for vmap backed memory.
  1575	
  1576		  shmem
  1577			Amount of cached filesystem data that is swap-backed,
  1578			such as tmpfs, shm segments, shared anonymous mmap()s
  1579	
  1580		  zswap
  1581			Amount of memory consumed by the zswap compression backend.
  1582	
  1583		  zswapped
  1584			Amount of application memory swapped out to zswap.
  1585	
  1586		  file_mapped
  1587			Amount of cached filesystem data mapped with mmap(). Note
  1588			that some kernel configurations might account complete
  1589			larger allocations (e.g., THP) if only some, but not
  1590			not all the memory of such an allocation is mapped.
  1591	
  1592		  file_dirty
  1593			Amount of cached filesystem data that was modified but
  1594			not yet written back to disk
  1595	
  1596		  file_writeback
  1597			Amount of cached filesystem data that was modified and
  1598			is currently being written back to disk
  1599	
  1600		  swapcached
  1601			Amount of swap cached in memory. The swapcache is accounted
  1602			against both memory and swap usage.
  1603	
  1604		  anon_thp
  1605			Amount of memory used in anonymous mappings backed by
  1606			transparent hugepages
  1607	
  1608		  file_thp
  1609			Amount of cached filesystem data backed by transparent
  1610			hugepages
  1611	
  1612		  shmem_thp
  1613			Amount of shm, tmpfs, shared anonymous mmap()s backed by
  1614			transparent hugepages
  1615	
  1616		  inactive_anon, active_anon, inactive_file, active_file, unevictable
  1617			Amount of memory, swap-backed and filesystem-backed,
  1618			on the internal memory management lists used by the
  1619			page reclaim algorithm.
  1620	
  1621			As these represent internal list state (eg. shmem pages are on anon
  1622			memory management lists), inactive_foo + active_foo may not be equal to
  1623			the value for the foo counter, since the foo counter is type-based, not
  1624			list-based.
  1625	
  1626		  slab_reclaimable
  1627			Part of "slab" that might be reclaimed, such as
  1628			dentries and inodes.
  1629	
  1630		  slab_unreclaimable
  1631			Part of "slab" that cannot be reclaimed on memory
  1632			pressure.
  1633	
  1634		  slab (npn)
  1635			Amount of memory used for storing in-kernel data
  1636			structures.
  1637	
  1638		  workingset_refault_anon
  1639			Number of refaults of previously evicted anonymous pages.
  1640	
  1641		  workingset_refault_file
  1642			Number of refaults of previously evicted file pages.
  1643	
  1644		  workingset_activate_anon
  1645			Number of refaulted anonymous pages that were immediately
  1646			activated.
  1647	
  1648		  workingset_activate_file
  1649			Number of refaulted file pages that were immediately activated.
  1650	
  1651		  workingset_restore_anon
  1652			Number of restored anonymous pages which have been detected as
  1653			an active workingset before they got reclaimed.
  1654	
  1655		  workingset_restore_file
  1656			Number of restored file pages which have been detected as an
  1657			active workingset before they got reclaimed.
  1658	
  1659		  workingset_nodereclaim
  1660			Number of times a shadow node has been reclaimed
  1661	
  1662		  pswpin (npn)
  1663			Number of pages swapped into memory
  1664	
  1665		  pswpout (npn)
  1666			Number of pages swapped out of memory
  1667	
  1668		  pgscan (npn)
  1669			Amount of scanned pages (in an inactive LRU list)
  1670	
  1671		  pgsteal (npn)
  1672			Amount of reclaimed pages
  1673	
  1674		  pgscan_kswapd (npn)
  1675			Amount of scanned pages by kswapd (in an inactive LRU list)
  1676	
  1677		  pgscan_direct (npn)
  1678			Amount of scanned pages directly  (in an inactive LRU list)
  1679	
  1680		  pgscan_khugepaged (npn)
  1681			Amount of scanned pages by khugepaged  (in an inactive LRU list)
  1682	
  1683		  pgscan_proactive (npn)
  1684			Amount of scanned pages proactively (in an inactive LRU list)
  1685	
  1686		  pgsteal_kswapd (npn)
  1687			Amount of reclaimed pages by kswapd
  1688	
  1689		  pgsteal_direct (npn)
  1690			Amount of reclaimed pages directly
  1691	
  1692		  pgsteal_khugepaged (npn)
  1693			Amount of reclaimed pages by khugepaged
  1694	
  1695		  pgsteal_proactive (npn)
  1696			Amount of reclaimed pages proactively
  1697	
  1698		  pgfault (npn)
  1699			Total number of page faults incurred
  1700	
  1701		  pgmajfault (npn)
  1702			Number of major page faults incurred
  1703	
  1704		  pgrefill (npn)
  1705			Amount of scanned pages (in an active LRU list)
  1706	
  1707		  pgactivate (npn)
  1708			Amount of pages moved to the active LRU list
  1709	
  1710		  pgdeactivate (npn)
  1711			Amount of pages moved to the inactive LRU list
  1712	
  1713		  pglazyfree (npn)
  1714			Amount of pages postponed to be freed under memory pressure
  1715	
  1716		  pglazyfreed (npn)
  1717			Amount of reclaimed lazyfree pages
  1718	
  1719		  swpin_zero
  1720			Number of pages swapped into memory and filled with zero, where I/O
  1721			was optimized out because the page content was detected to be zero
  1722			during swapout.
  1723	
  1724		  swpout_zero
  1725			Number of zero-filled pages swapped out with I/O skipped due to the
  1726			content being detected as zero.
  1727	
  1728		  zswpin
  1729			Number of pages moved in to memory from zswap.
  1730	
  1731		  zswpout
  1732			Number of pages moved out of memory to zswap.
  1733	
  1734		  zswpwb
  1735			Number of pages written from zswap to swap.
  1736	
  1737		  zswap_incomp
  1738			Number of incompressible pages currently stored in zswap
  1739			without compression. These pages could not be compressed to
  1740			a size smaller than PAGE_SIZE, so they are stored as-is.
  1741	
  1742		  thp_fault_alloc (npn)
  1743			Number of transparent hugepages which were allocated to satisfy
  1744			a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
  1745	                is not set.
  1746	
  1747		  thp_collapse_alloc (npn)
  1748			Number of transparent hugepages which were allocated to allow
  1749			collapsing an existing range of pages. This counter is not
  1750			present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
  1751	
  1752		  thp_swpout (npn)
  1753			Number of transparent hugepages which are swapout in one piece
  1754			without splitting.
  1755	
  1756		  thp_swpout_fallback (npn)
  1757			Number of transparent hugepages which were split before swapout.
  1758			Usually because failed to allocate some continuous swap space
  1759			for the huge page.
  1760	
  1761		  numa_pages_migrated (npn)
  1762			Number of pages migrated by NUMA balancing.
  1763	
  1764		  numa_pte_updates (npn)
  1765			Number of pages whose page table entries are modified by
  1766			NUMA balancing to produce NUMA hinting faults on access.
  1767	
  1768		  numa_hint_faults (npn)
  1769			Number of NUMA hinting faults.
  1770	
  1771		  pgdemote_kswapd
  1772			Number of pages demoted by kswapd.
  1773	
  1774		  pgdemote_direct
  1775			Number of pages demoted directly.
  1776	
  1777		  pgdemote_khugepaged
  1778			Number of pages demoted by khugepaged.
  1779	
  1780		  pgdemote_proactive
  1781			Number of pages demoted by proactively.
  1782	
  1783		  hugetlb
  1784			Amount of memory used by hugetlb pages. This metric only shows
  1785			up if hugetlb usage is accounted for in memory.current (i.e.
  1786			cgroup is mounted with the memory_hugetlb_accounting option).
  1787	
  1788	  memory.numa_stat
  1789		A read-only nested-keyed file which exists on non-root cgroups.
  1790	
  1791		This breaks down the cgroup's memory footprint into different
  1792		types of memory, type-specific details, and other information
  1793		per node on the state of the memory management system.
  1794	
  1795		This is useful for providing visibility into the NUMA locality
  1796		information within an memcg since the pages are allowed to be
  1797		allocated from any physical node. One of the use case is evaluating
  1798		application performance by combining this information with the
  1799		application's CPU allocation.
  1800	
  1801		All memory amounts are in bytes.
  1802	
  1803		The output format of memory.numa_stat is::
  1804	
  1805		  type N0=<bytes in node 0> N1=<bytes in node 1> ...
  1806	
  1807		The entries are ordered to be human readable, and new entries
  1808		can show up in the middle. Don't rely on items remaining in a
  1809		fixed position; use the keys to look up specific values!
  1810	
  1811		The entries can refer to the memory.stat.
  1812	
  1813	  memory.swap.current
  1814		A read-only single value file which exists on non-root
  1815		cgroups.
  1816	
  1817		The total amount of swap currently being used by the cgroup
  1818		and its descendants.
  1819	
  1820	  memory.swap.high
  1821		A read-write single value file which exists on non-root
  1822		cgroups.  The default is "max".
  1823	
  1824		Swap usage throttle limit.  If a cgroup's swap usage exceeds
  1825		this limit, all its further allocations will be throttled to
  1826		allow userspace to implement custom out-of-memory procedures.
  1827	
  1828		This limit marks a point of no return for the cgroup. It is NOT
  1829		designed to manage the amount of swapping a workload does
  1830		during regular operation. Compare to memory.swap.max, which
  1831		prohibits swapping past a set amount, but lets the cgroup
  1832		continue unimpeded as long as other memory can be reclaimed.
  1833	
  1834		Healthy workloads are not expected to reach this limit.
  1835	
  1836	  memory.swap.peak
  1837		A read-write single value file which exists on non-root cgroups.
  1838	
  1839		The max swap usage recorded for the cgroup and its descendants since
  1840		the creation of the cgroup or the most recent reset for that FD.
  1841	
  1842		A write of any non-empty string to this file resets it to the
  1843		current memory usage for subsequent reads through the same
  1844		file descriptor.
  1845	
  1846	  memory.swap.max
  1847		A read-write single value file which exists on non-root
  1848		cgroups.  The default is "max".
  1849	
  1850		Swap usage hard limit.  If a cgroup's swap usage reaches this
  1851		limit, anonymous memory of the cgroup will not be swapped out.
  1852	
  1853	  memory.swap.tiers
  1854	        A read-write file which exists on non-root cgroups.
  1855	        Format is similar to cgroup.subtree_control.
  1856	
  1857	        Controls which swap tiers this cgroup is allowed to swap
  1858	        out to. All tiers are enabled by default.
  1859	
> 1860	          (-|+)TIER [(-|+)TIER ...]
  1861	
  1862	        "-" disables a tier, "+" re-enables it.
  1863	        Entries are whitespace-delimited.
  1864	
  1865	        Changes here are combined with parent restrictions to
  1866	        compute memory.swap.tiers.effective.
  1867	
  1868	        If a tier is removed from /sys/kernel/mm/swap/tiers,
  1869	        any prior disable for that tier is invalidated.
  1870	
  1871	  memory.swap.tiers.effective
  1872	        A read-only file which exists on non-root cgroups.
  1873	
  1874	        Shows the tiers this cgroup can actually swap out to.
  1875	        This is the intersection of the parent's effective tiers
  1876	        and this cgroup's own memory.swap.tiers configuration.
  1877	        A child cannot enable a tier that is disabled in its
  1878	        parent.
  1879	
  1880	  memory.swap.events
  1881		A read-only flat-keyed file which exists on non-root cgroups.
  1882		The following entries are defined.  Unless specified
  1883		otherwise, a value change in this file generates a file
  1884		modified event.
  1885	
  1886		  high
  1887			The number of times the cgroup's swap usage was over
  1888			the high threshold.
  1889	
  1890		  max
  1891			The number of times the cgroup's swap usage was about
  1892			to go over the max boundary and swap allocation
  1893			failed.
  1894	
  1895		  fail
  1896			The number of times swap allocation failed either
  1897			because of running out of swap system-wide or max
  1898			limit.
  1899	
  1900		When reduced under the current usage, the existing swap
  1901		entries are reclaimed gradually and the swap usage may stay
  1902		higher than the limit for an extended period of time.  This
  1903		reduces the impact on the workload and memory management.
  1904	
  1905	  memory.zswap.current
  1906		A read-only single value file which exists on non-root
  1907		cgroups.
  1908	
  1909		The total amount of memory consumed by the zswap compression
  1910		backend.
  1911	
  1912	  memory.zswap.max
  1913		A read-write single value file which exists on non-root
  1914		cgroups.  The default is "max".
  1915	
  1916		Zswap usage hard limit. If a cgroup's zswap pool reaches this
  1917		limit, it will refuse to take any more stores before existing
  1918		entries fault back in or are written out to disk.
  1919	
  1920	  memory.zswap.writeback
  1921		A read-write single value file. The default value is "1".
  1922		Note that this setting is hierarchical, i.e. the writeback would be
  1923		implicitly disabled for child cgroups if the upper hierarchy
  1924		does so.
  1925	
  1926		When this is set to 0, all swapping attempts to swapping devices
  1927		are disabled. This included both zswap writebacks, and swapping due
  1928		to zswap store failures. If the zswap store failures are recurring
  1929		(for e.g if the pages are incompressible), users can observe
  1930		reclaim inefficiency after disabling writeback (because the same
  1931		pages might be rejected again and again).
  1932	
  1933		Note that this is subtly different from setting memory.swap.max to
  1934		0, as it still allows for pages to be written to the zswap pool.
  1935		This setting has no effect if zswap is disabled, and swapping
  1936		is allowed unless memory.swap.max is set to 0.
  1937	
  1938	  memory.pressure
  1939		A read-only nested-keyed file.
  1940	
  1941		Shows pressure stall information for memory. See
  1942		:ref:`Documentation/accounting/psi.rst <psi>` for details.
  1943	
  1944	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

